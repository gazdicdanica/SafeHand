import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tech_says_no/model/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.location});

  final PlaceLocation location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.latitude, widget.location.longitude),
            zoom: 16),
        markers: {
          Marker(
            markerId: const MarkerId('Location'),
            position: LatLng(widget.location.latitude, widget.location.longitude),
          )
        }
      ),
    );
  }
}
