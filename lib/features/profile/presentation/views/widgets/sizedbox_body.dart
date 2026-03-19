import 'package:flutter/material.dart';

class SizedBoxBody extends StatelessWidget {
  const SizedBoxBody({
    super.key,
    required this.text,
    required this.fontsize,
    required this.color,
  });

  final String text;
  final double? fontsize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
