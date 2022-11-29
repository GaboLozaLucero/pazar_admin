import 'dart:io';

import 'package:admin_project_v1/models/stories.dart';
import 'package:admin_project_v1/services/stories_service.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class AddStoriesController extends GetxController {
  final RxString _selectedType = 'Mito'.obs; //dropdown button starts type of story
  final List<String> storyType = ['Mito', 'Leyenda'];

  set selectedType(String value) {
    _selectedType.value = value;
  }

  String get selectedType => _selectedType.value; //dropdown button ends type of story

  final RxString _isActive = 'Activado'.obs; //dropdown button starts type of active
  final List<String> activeType = ['Activado', 'Desactivado'];

  set selectedActive(String value) {
    _isActive.value = value;
  }

  String get selectedActive => _isActive.value; //dropdown button ends type of active

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final StoriesService _storiesService = StoriesService();

  final ImagePicker _imagePicker = ImagePicker();

  late final Rx<String> _portraitPath = ('./././assets/images/default_image.png').obs;

  String get portraitPath => _portraitPath.value;

  takeImage(int type) async {
    XFile? portrait = XFile('./././assets/images/default_image.png');
    if (type == 1) {
      portrait = await _imagePicker.pickImage(source: ImageSource.camera);
    } else {
      portrait = await _imagePicker.pickImage(source: ImageSource.gallery);
    }
    log('this is the portrait path${portrait?.path}');
    if(portrait?.path != null){
      _isLoading.value = true;
      String portraitName = DateTime.now().millisecondsSinceEpoch.toString();
      _portraitPath.value = await _storiesService.uploadPortrait(portraitName, File(portrait!.path));
      log(_portraitPath.value);
      _isLoading.value = false;
    }
  }

  Future<bool> saveStory(Story story) async {
    bool storyCreated = false;
    _isLoading.value = true;
    storyCreated = await _storiesService.saveStory(story);
    _isLoading.value = false;
    return storyCreated;
  }

  resetControllers(){
    _portraitPath.value = ('./././assets/images/default_image.png');
  }
}
