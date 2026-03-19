import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/sizedbox_body.dart';

class RowProfileData extends StatelessWidget {
  RowProfileData({
    super.key,
    required this.profileTabProvider,
    required this.text,
    this.color,
    this.fontsize,
  });

  final ProfileTabProvider profileTabProvider;
  final String text;
  Color? color;
  double? fontsize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: SizedBoxBody(text: text, fontsize: fontsize, color: color),
        ),
      ],
    );
  }
}
