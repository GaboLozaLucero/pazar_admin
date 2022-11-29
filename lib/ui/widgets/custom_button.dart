import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:admin_project_v1/ui/widgets/simple_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.function, required this.text, required this.iconData, this.width, this.height})
      : super(key: key);

  final Function function;
  final String text;
  final IconData iconData;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          // side: MaterialStateProperty.all(BorderSide(color: )),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SimpleText(
                text: text,
                color: ConstantColors.buttonColor,
              ),
            ),
            Icon(iconData, color: ConstantColors.buttonColor,),
          ],
        ),
      ),
    );
  }
}
