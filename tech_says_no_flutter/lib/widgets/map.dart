import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tech_says_no/model/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  // final PlaceLocation location;

  static const route = '/location';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    final location = PlaceLocation(
      latitude: double.parse(message.data['latitude']!),
      longitude: double.parse(message.data['longitude']!),
      address: message.data['address']!,
    );
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        // ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 16),
        markers: {
          Marker(
            markerId: const MarkerId('Location'),
            position: LatLng(location.latitude, location.longitude),
          )
        }
      ),
    );
  }
}
