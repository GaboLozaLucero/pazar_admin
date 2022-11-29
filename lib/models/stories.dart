import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  String? id;
  String? name;
  GeoPoint? geoPoint;
  String? address;
  String? story;
  String? imageUrl;
  bool? active;
  String? type;
  String? modelUrl;

  Story({this.id, this.name, this.geoPoint, this.address, this.story, this.imageUrl, this.active, this.type, this.modelUrl});

  factory Story.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Story(
        id: data?["id"],
        name: data?["name"],
        geoPoint: data?["geoPoint"],
        address: data?["address"],
        story: data?["story"],
        imageUrl: data?["image"],
        active: data?["active"],
        type: data?["type"],
        modelUrl: data?["model_url"]);
  }

  Map<String, dynamic> toFirestore() => {
        if (id != null) "id": id,
        if (name != null) "name": name,
        if (geoPoint != null) "geoPoint": geoPoint,
        if (address != null) "address": address,
        if (story != null) "story": story,
        if (imageUrl != null) "image": imageUrl,
        if (active != null) "active": active,
        if (type != null) "type": type,
        if (modelUrl != null) "model_url": modelUrl,
      };

  @override
  String toString() {
    return 'Story{id: $id, name: $name, geoPoint: $geoPoint, address: $address, story: $story, imageUrl: $imageUrl, active: '
        '$active, type: $type}';
  }
}
