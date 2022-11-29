import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key, required this.title, required this.function, required this.iconData}) : super(key: key);

  final String title;
  final Function function;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 0.7;
    double height = Get.height * 0.15;
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: ConstantColors.buttonColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          function();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              size: 70.0,
              color: ConstantColors.buttonColor,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                color: ConstantColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
