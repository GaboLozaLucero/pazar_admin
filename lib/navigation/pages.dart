import 'package:admin_project_v1/bindings/edit_story_binding.dart';
import 'package:admin_project_v1/bindings/home_binding.dart';
import 'package:admin_project_v1/bindings/review_stories_binding.dart';
import 'package:admin_project_v1/bindings/add_stories_binding.dart';
import 'package:admin_project_v1/ui/home_page.dart';
import 'package:admin_project_v1/ui/add_stories/add_stories_page.dart';
import 'package:admin_project_v1/ui/review_stories/edit_story_page.dart';
import 'package:admin_project_v1/ui/review_stories/review_legends_page.dart';
import 'package:admin_project_v1/ui/review_stories/review_myths_page.dart';
import 'package:get/get.dart';

part './routes.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.addStories,
      page: () => AddStoriesPage(),
      binding: AddStoriesBinding(),
    ),
    GetPage(
      name: Routes.reviewMythsStories,
      page: () => const ReviewMythsPage(),
      binding: ReviewStoriesBinding(),
    ),
    GetPage(
      name: Routes.reviewLegendsStories,
      page: () => const ReviewLegendsPage(),
      binding: ReviewStoriesBinding(),
    ),
    GetPage(
      name: Routes.editStory,
      page: () => EditStoryPage(),
      binding: EditStoryBinding(),
    ),
  ];
}
