import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final CameraPosition _shelter =
      CameraPosition(target: LatLng(55.001252, 73.461092), zoom: 15);
  final Marker _shelterMarker = Marker(
      markerId: MarkerId(0.toString()), position: LatLng(55.001252, 73.461092));
  Set<Marker> _markers = Set();

  _getMarkers(){
    setState(() {
      _markers.add(_shelterMarker);
    });
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _shelter,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      markers: _getMarkers(),
    );
  }
}
