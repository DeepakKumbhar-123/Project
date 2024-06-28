import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? _controller;
  Location _location = Location();
  LatLng _currentPosition = LatLng(37.7749, -122.4194); // Default to San Francisco

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 14.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hello User, your current location is: $_currentPosition',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
