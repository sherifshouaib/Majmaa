import 'package:flutter/material.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_inkwell_body.dart';

class ProfileOptionsInkWell extends StatelessWidget {
  const ProfileOptionsInkWell({
    super.key,
    required this.text,
    this.color = const Color.fromARGB(51, 96, 125, 139),
  });

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ProfileInkWellBody(color: color, text: text),

      onTap: () {},
    );
  }
}
