import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  const SimpleText({Key? key, required this.text, this.color}) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: color),);
  }
}
