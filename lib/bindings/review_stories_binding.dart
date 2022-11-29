import 'package:admin_project_v1/controllers/review_stories_controller.dart';
import 'package:get/get.dart';

class ReviewStoriesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewStoriesController(), fenix: true);
  }

}