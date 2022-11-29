// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

class AddStoriesMapController extends GetxController {
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final RxBool _isLoading1 = false.obs;

  bool get isLoading1 => _isLoading1.value;

  late GoogleMapController _googleMapController;

  onMapCreated(GoogleMapController googleMapController) {
    _googleMapController = googleMapController;
  }

  final RxSet<Marker> _newMarker = {
    Marker(
      markerId: MarkerId('Story'),
      position: LatLng(0.0, 0.0),
    )
  }.obs;

  Set<Marker> get newMarker => _newMarker.value;

  setMarker(LatLng tappedPoint) {
    _newMarker.clear();
    log('latitude ${tappedPoint.latitude}');
    log('longitude ${tappedPoint.longitude}');
    _newMarker.add(Marker(
      markerId: const MarkerId('Story'),
      position: tappedPoint,
    ));
    _isLoading.value = true;
  }

  resetMarker(){
    _newMarker.clear();
    _newMarker.add(Marker(
      markerId: MarkerId('Story'),
      position: LatLng(0.0, 0.0),
    ));
  }
}
