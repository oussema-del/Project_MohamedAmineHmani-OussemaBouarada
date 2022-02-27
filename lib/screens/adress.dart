import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ihm/constants/fire_base_constants.dart';
import 'package:ihm/screens/home/home_shop.dart';

import '../constants/controllers.dart';

class AdressMap extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adress"),
        leading: IconButton(
          onPressed: () {
            Get.offAll(const HomeScreen());
          },
          icon: const Icon(Icons.keyboard_return_rounded),
        ),
      ),
      body: Stack(children: [
       
        GoogleMap(
          markers: Set<Marker>.of(mapController.markers.values),
          myLocationEnabled: true,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(34.72886331178963, 10.737858915101318),
            zoom: 18.4746,
          ),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            Completer();
          },
        )
      ]),
    );
  }
}
