import 'package:admin_project_v1/controllers/add_stories_map_controller.dart';
import 'package:admin_project_v1/controllers/edit_story_controller.dart';
import 'package:get/get.dart';

class EditStoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditStoryController(), fenix: true);
    Get.lazyPut(() => AddStoriesMapController(), fenix: true);
  }
}