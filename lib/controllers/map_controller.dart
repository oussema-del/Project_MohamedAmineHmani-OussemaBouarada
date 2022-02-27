import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapController extends GetxController {
  static MapController instance = Get.find();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void _add() {
    var markerIdVal = const Uuid().v1();
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(34.72886331178963, 10.737858915101318),
      infoWindow: const InfoWindow(
        title: "private North American university ",
      ),
      onTap: () {},
    );

    // adding a new marker to map
    markers[markerId] = marker;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  /* _getUserLocation() async {
    Position position = await _determinePosition();

    _initialPosition = LatLng(position.latitude, position.longitude);
  }*/

  @override
  onReady() {
    super.onReady();
    _determinePosition();
    _add();
  }
}
