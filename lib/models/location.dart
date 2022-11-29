import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  String? geohash;
  GeoPoint? geoPoint;

  Location({this.geohash, this.geoPoint});

  factory Location.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Location(
        geohash: data?["geohash"],
        geoPoint: data?["geoPoint"]);
  }

  Map<String, dynamic> toFirestore() => {
    if (geohash != null) "geohash": geohash,
    if (geoPoint != null) "geoPoint": geoPoint,
  };
}