import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';

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

    print("addressLine-------------->${addresses.first.addressLine}");
    print("locality-------------->${addresses.first.locality}");
    print("featureName-------------->${addresses.first.featureName}");
    print("thoroughfare-------------->${addresses.first.thoroughfare}");
    print("adminArea-------------->${addresses.first.adminArea}");
    print("countryCode-------------->${addresses.first.countryCode}");
    print("countryName-------------->${addresses.first.countryName}");
    print("postalCode-------------->${addresses.first.postalCode}");

    setState(() {
      _address = addresses.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Popup for a marker!",
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            DefaultText(
              value: "Address:",
            ),
            Text(
              "Marker size: ${_marker.width}, ${_marker.height}",
              style: const TextStyle(fontSize: 12.0),
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
  final PopupController _popupLayerController = PopupController();
  static final List<LatLng> _points = [
    LatLng(48.856614, 2.3522219),
    LatLng(43.3, 5.4),
    LatLng(50.633333, 3.066667),
  ];

  static const _markerSize = 50.0;
  List<Marker> _markers;

  @override
  void initState() {
    super.initState();

    _markers = _points
        .map(
          (LatLng point) => Marker(
            point: point,
            width: _markerSize,
            height: _markerSize,
            builder: (_) =>
                Icon(Icons.location_pin, size: _markerSize, color: Colors.red),
            anchorPos: AnchorPos.align(AnchorAlign.top),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: _points.first,
        zoom: 13.0,
        plugins: [PopupMarkerPlugin()],
        onTap: (_) => _popupLayerController.hidePopup(),
      ),
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
