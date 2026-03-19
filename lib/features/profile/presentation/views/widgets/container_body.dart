import 'package:flutter/material.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 40) * 0.6,
          child: Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Icon(Icons.arrow_forward_ios_outlined),
      ],
    );
  }
}
