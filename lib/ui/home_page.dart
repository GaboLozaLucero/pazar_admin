import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:admin_project_v1/navigation/pages.dart';
import 'package:admin_project_v1/ui/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: Get.height * 0.2,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: ConstantColors.textColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    '././assets/images/logo_admin.png',
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MenuButton(
                      title: 'Agregar historia',
                      function: () {
                        Get.toNamed(Routes.addStories);
                      },
                      iconData: Icons.add_comment,
                    ),
                    MenuButton(
                      title: 'Revisar mitos',
                      function: () {
                        Get.toNamed(Routes.reviewMythsStories);
                      },
                      iconData: Icons.edit_note_outlined,
                    ),
                    MenuButton(
                      title: 'Revisar leyendas',
                      function: () {
                        Get.toNamed(Routes.reviewLegendsStories);
                      },
                      iconData: Icons.edit_note_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
