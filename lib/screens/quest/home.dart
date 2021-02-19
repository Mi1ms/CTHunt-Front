import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';
import 'package:ct_hunt/utils/size_config.dart';
import 'package:ct_hunt/screens/quest/add.dart';
import 'package:ct_hunt/screens/quest/play.dart';
import 'package:ct_hunt/widgets/CircularProgress.dart';
import 'package:ct_hunt/data/model_parsers.dart';
import 'package:ct_hunt/data/models.dart';
import 'package:ct_hunt/data/colors.dart';
import 'package:ct_hunt/services/api/quest.dart' as Api;
import 'package:ct_hunt/widgets/DefaultText.dart';

class QuestInfo extends StatelessWidget {
  final String label;
  final String value;

  const QuestInfo({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DefaultText(
          value: label,
          fontWeight: FontWeight.w500,
        ),
        DefaultText(
          value: value,
        ),
      ],
    );
  }
}

class MarkerPopUp extends StatefulWidget {
  final Quest quest;

  const MarkerPopUp({Key key, this.quest}) : super(key: key);

  @override
  _MarkerPopUpState createState() => _MarkerPopUpState(this.quest);
}

class _MarkerPopUpState extends State<MarkerPopUp> {
  _MarkerPopUpState(this._quest);

  Quest _quest;
  Address _address = Address();

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  void getAddress() async {
    Coordinates coordinates =
        new Coordinates(_quest.latitude, _quest.longitude);

    try {
      List<Address> addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      setState(() {
        _address = addresses.first;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget addressInfo = _address.addressLine != null
        ? QuestInfo(label: "Address: ", value: _address.addressLine)
        : SizedBox();
    return Card(
      child: Container(
        padding: EdgeInsets.all(5.56 * SizeConfig.widthMultiplier),
        width: 69.44 * SizeConfig.widthMultiplier,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            QuestInfo(label: "Title: ", value: _quest.title),
            SizedBox(height: 12),
            QuestInfo(label: "Level: ", value: _quest.level.capitalize),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.49 * SizeConfig.heightMultiplier)),
            addressInfo,
            Center(
              child: FittedBox(
                child: InkWell(
                  onTap: (){
                    print(_quest.toString());
                    Get.toNamed(Play.routeName, arguments: PlayArguments(quest: _quest));
                  },
                  child: DefaultText(
                    value: "Let's go!",
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.only(top: 6),
                    backgroundColor: DefaultColors.primary[600],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _markerSize = 50.0;
  final PopupController _popupLayerController = PopupController();
  List<LatLng> _points = [];
  List<Marker> _markers;
  List<Quest> _quests;

  @override
  void initState() {
    super.initState();
    getPoints();
  }

  void getPoints() async {
    try {
      dio.Response<dynamic> response = await Api.Quest.getAll();
      var data = response.data;
      List<Quest> quests = parseQuests(data["data"]);
      List<LatLng> points = quests
          .map((Quest quest) => LatLng(quest.latitude, quest.longitude))
          .toList()
          .cast<LatLng>();
      List<Marker> markers = points
          .map(
            (LatLng point) => Marker(
              point: point,
              width: _markerSize,
              height: _markerSize,
              builder: (_) => Icon(Icons.location_pin,
                  size: _markerSize, color: Colors.red),
              anchorPos: AnchorPos.align(AnchorAlign.top),
            ),
          )
          .toList();
      setState(() {
        _points = points;
        _markers = markers;
        _quests = quests;
      });
    } on dio.DioError catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_points.length == 0)
      return Scaffold(
        body: Center(
          child: CircularProgress(),
        ),
      );
    return FlutterMap(
      options: MapOptions(
          center: _points.first,
          zoom: 13.0,
          plugins: [PopupMarkerPlugin()],
          onTap: (_) => _popupLayerController.hidePopup(),
          onLongPress: (LatLng position) {
            Get.toNamed(AddRiddle.routeName,
                arguments: PositionArguments(
                    latitude: position.latitude,
                    longitude: position.longitude
                )
            );
          }),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        PopupMarkerLayerOptions(
            markers: _markers,
            popupSnap: PopupSnap.top,
            popupController: _popupLayerController,
            popupBuilder: (BuildContext _, Marker marker) {
              var index = _markers.indexOf(marker);
              return MarkerPopUp(quest: _quests[index]);
            }),
      ],
    );
  }
}
