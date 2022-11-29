import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key, required this.title,}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: ConstantColors.textColor,
        ),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white70,
      leading: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 0.0,
              style: BorderStyle.none,
            ),
          ),
          shadowColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: ConstantColors.buttonColor,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
