import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/system_settings.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  var _lng = 0.0;
  var _lat = 0.0;

  final Marker cafe = Marker(
    markerId: MarkerId(''),
    position: LatLng(-37.83954, 144.994618),
    infoWindow: InfoWindow(
      title: 'Cafe La Fontaine',
      snippet: '220 Toorak Rd',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SystemSettings>(context, listen: false)
          .fetchAndSetSystemSettings(),
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error != null) {
            return Center(
              child: Text('Error loading map'),
            );
          } else {
            _lng = Provider.of<SystemSettings>(context, listen: false)
                .systemSettings
                .locationLng;
            _lat = Provider.of<SystemSettings>(context, listen: false)
                .systemSettings
                .locationLat;

            return Stack(
              children: [
                GoogleMap(
                  mapType: _currentMapType,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {cafe},
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_lat, _lng),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.map,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
