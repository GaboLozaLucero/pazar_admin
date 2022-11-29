import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:flutter/material.dart';

class FormFieldLongText extends StatelessWidget {
  const FormFieldLongText({Key? key, required this.controller, this.hint, required this.iconData}) : super(key: key);

  final TextEditingController controller;
  final String? hint;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: 7,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'El campo debe ser llenado';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          suffixIcon: Icon(
            iconData,
            color: ConstantColors.buttonColor,
          ),
        ),
        cursorHeight: 25,
      ),
    );
  }
}
