import 'dart:developer';
import 'dart:io';
import 'package:admin_project_v1/models/stories.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as CloudFirestore;
import 'package:firebase_storage/firebase_storage.dart';

class StoriesService {
  final CloudFirestore.FirebaseFirestore _db = CloudFirestore.FirebaseFirestore.instance;
  static const String storiesPath = 'stories';

  Future<String> uploadPortrait(String imageName, File filePath) async {
    try {
      Reference reference = FirebaseStorage.instance.ref();
      Reference referenceDirImages = reference.child('images');
      Reference referenceUploadImage = referenceDirImages.child(imageName); //
      // creates a reference where the image will be stored
      await referenceUploadImage.putFile(filePath);
      return await referenceUploadImage.getDownloadURL();
    } catch (e) {
      log('this is an error ${e.toString()}');
      return './././assets/images/default_image.png';
    }
  }

  Future<bool> saveStory(Story story) async {
    try {
      CloudFirestore.DocumentReference reference = _db.collection(storiesPath).doc(story.id);
      Map<String, dynamic> storyToFirestore = story.toFirestore();
      storyToFirestore.putIfAbsent('created_at', () => CloudFirestore.FieldValue.serverTimestamp());
      storyToFirestore.putIfAbsent('id', () => reference.id);
      await reference.set(storyToFirestore);
      log('this was just created${storyToFirestore.toString()}');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Story>?> retrieveStories(String type) async {
    try {
      final storiesQuery = await _db
          .collection(storiesPath)
          .where('active', isEqualTo: true).where('type', isEqualTo: type)
          .get();
      // final stories = storiesQuery.docs.map((story) => Story.fromFirestore(story, null)).toList();
      // log(storiesQuery.docs.map((story) => Story().toString()).toList()[1]);
      return storiesQuery.docs.map((story) => Story.fromFirestore(story, null)).toList();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> updateStory(Story story) async{
    try{
      CloudFirestore.DocumentReference reference = _db.collection(storiesPath).doc(story.id);
      return true;
    }catch(e){
      log(e.toString());
      return false;
    }
  }
}
