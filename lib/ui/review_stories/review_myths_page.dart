import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:admin_project_v1/controllers/review_stories_controller.dart';
import 'package:admin_project_v1/navigation/pages.dart';
import 'package:admin_project_v1/ui/widgets/custom_appbar.dart';
import 'package:admin_project_v1/ui/widgets/story_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewMythsPage extends GetView<ReviewStoriesController> {
  const ReviewMythsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const CustomAppBar(title: 'Revisar mitos'),
          body: GetX<ReviewStoriesController>(
            initState: (state) async {
              await controller.retrieveStories('myth');
            },
            builder: (controlling) {
              if (controlling.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StoryCard(
                stories: controlling.listStories,
                function: (index){
                  Get.toNamed(Routes.editStory, arguments: controlling.listStories[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
