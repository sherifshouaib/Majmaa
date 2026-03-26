import 'package:flutter/material.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_inkwell_body.dart';

class ProfileOptionsInkWell extends StatelessWidget {
  const ProfileOptionsInkWell({
    super.key,
    required this.text,
    this.color = const Color.fromARGB(51, 96, 125, 139),
    required this.ontap,
  });

  final String text;
  final Color color;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ProfileInkWellBody(color: color, text: text),
    );
  }
}
