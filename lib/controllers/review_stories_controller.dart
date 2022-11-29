import 'package:admin_project_v1/models/stories.dart';
import 'package:admin_project_v1/services/stories_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewStoriesController extends GetxController {
  final StoriesService _storiesService = StoriesService();

  final RxList<Story> _listStories = <Story>[].obs;

  List<Story> get listStories => _listStories.value;

  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  Future retrieveStories(String type) async {
    _loading.value = true;
    final result = await _storiesService.retrieveStories(type);
    _listStories.value = result!;
    _loading.value = false;
  }
}
