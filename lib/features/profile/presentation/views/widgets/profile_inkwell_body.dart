import 'package:flutter/material.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/container_body.dart';

class ProfileInkWellBody extends StatelessWidget {
  const ProfileInkWellBody({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
    
        //     color: Colors.blueGrey.withOpacity(0.2),
      ),
      child: ContainerBody(text: text),
    );
  }
}