import 'package:admin_project_v1/controllers/add_stories_controller.dart';
import 'package:admin_project_v1/controllers/add_stories_map_controller.dart';
import 'package:get/get.dart';

class AddStoriesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddStoriesController(), fenix: true);
    Get.lazyPut(() => AddStoriesMapController(), fenix: true);
  }
}