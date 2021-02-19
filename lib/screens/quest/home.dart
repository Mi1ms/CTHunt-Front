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
import 'package:ct_hunt/widgets/CircularProgress.dart';
import 'package:ct_hunt/data/model_parsers.dart';
import 'package:ct_hunt/data/models.dart';
import 'package:ct_hunt/services/api/quest.dart' as Api;
import 'package:ct_hunt/widgets/DefaultText.dart';

class MarkerPopUp extends StatefulWidget {
  final Marker marker;

  const MarkerPopUp({Key key, this.marker}) : super(key: key);

  @override
  _MarkerPopUpState createState() => _MarkerPopUpState(this.marker);
}

class _MarkerPopUpState extends State<MarkerPopUp> {
  _MarkerPopUpState(this._marker);

  final Marker _marker;
  Address _address = Address();

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  void getAddress() async {
    Coordinates coordinates =
        new Coordinates(_marker.point.latitude, _marker.point.longitude);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      _address = addresses.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(2.31 * SizeConfig.widthMultiplier),
        constraints: BoxConstraints(
            minWidth: 23.15 * SizeConfig.widthMultiplier,
            maxWidth: 46.29 * SizeConfig.widthMultiplier),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Popup for a marker!",
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 1.72 * SizeConfig.textMultiplier,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.49 * SizeConfig.heightMultiplier)),
            DefaultText(
              value: "Address:",
            ),
            Text(
              "Marker size: ${_marker.width}, ${_marker.height}",
              style: TextStyle(fontSize: 1.47 * SizeConfig.textMultiplier),
            ),
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
      List<Quest> quests = parseQuests(data ["data"]);
      List<LatLng> points = quests
          .map((Quest quest) => LatLng(quest.latitude, quest.longitude))
          .toList().cast<LatLng>();
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
    } on dio.DioError catch (e) {
    }
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
                    longitude: position.longitude));
          }),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        PopupMarkerLayerOptions(
          markers: _markers,
          popupSnap: PopupSnap.top,
          popupController: _popupLayerController,
          popupBuilder: (BuildContext _, Marker marker) =>
              MarkerPopUp(marker: marker),
        ),
      ],
    );
  }
}
