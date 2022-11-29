import 'package:admin_project_v1/models/stories.dart';
import 'package:admin_project_v1/services/stories_service.dart';
import 'package:get/get.dart';

class EditStoryController extends GetxController {
  Story story = Get.arguments;
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
}
