import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/features/posts/presentation/views/widgets/choose_photo_section.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../main_development.dart';
import 'choose_video_section.dart';

class ChooseMediaIcon extends StatelessWidget {
  const ChooseMediaIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // final postProvider = Provider.of<PostProvider>(context);

    return InkWell(
      child: Icon(Icons.photo_camera_outlined),
      onTap: () {
        showDialog(
          context: context,
          builder: (_1) => fluent.ContentDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocale.chooseMediaLabel.getString(context),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Directionality(
              textDirection: localization.currentLocale.localeIdentifier == "ar"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChoosePhotoSection(parentDialogContext: _1),

                  verticalSpace(5),

                  ChooseVideoSection(parentDialogContext: _1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
