import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ihm/constants/fire_base_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static LatLng _initialPosition=LatLng(-15.4630239974464, 28.363397732282127);
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();

  }
   _getUserLocation() async {
    Position position = await _determinePosition();

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);


    });
  }

  @override
   initState()  {
    super.initState();
   _getUserLocation();



  }

 final Completer<GoogleMapController> _controllerMaps = Completer();
  final  CameraPosition _kGooglePlex = CameraPosition(
    target:_initialPosition ,
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main screen"),leading:ElevatedButton(
        onPressed: () async {
          authController.signOut();
        },
        child: const Text("signout"),
      ),),
      body: Stack(
        children:[
          GoogleMap(initialCameraPosition: _kGooglePlex,
          mapType:MapType.normal ,
          onMapCreated: (GoogleMapController controller){
            _controllerMaps.complete(controller);

          },)
        ]
      ),
    );
  }
}
