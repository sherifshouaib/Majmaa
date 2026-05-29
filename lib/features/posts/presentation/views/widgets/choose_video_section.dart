import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/post_provider.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/utils/controllers/comments_controller.dart';

class ChooseVideoSection extends StatelessWidget {
  const ChooseVideoSection({super.key, required this.parentDialogContext});
  final BuildContext parentDialogContext;

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Material(
      child: ListTile(
        title: Text(AppLocale.videoLabel.getString(context)),
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: () {
          showDialog(
            context: parentDialogContext,
            builder: (_2) => fluent.ContentDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocale.chooseSourceLabel.getString(context),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              content: Directionality(
                textDirection:
                    localization.currentLocale.localeIdentifier == "ar"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      child: ListTile(
                        title: Text(AppLocale.cameraLabel.getString(context)),
                        dense: true,
                        visualDensity: VisualDensity.compact,

                        onTap: () async {
                          postProvider.setIsLoading(true);
                          try {
                            ImagePicker imagePicker = ImagePicker();

                            var file = await imagePicker.pickVideo(
                              source: ImageSource.camera,
                            );
                            if (file != null) {
                              var res =
                                  await CommentsController.uploadCommentVideo(
                                    File(file.path),
                                  );
                              if (res["result"] == true) {
                                postProvider.setAddMediaUrl(
                                  res["url"].toString(),
                                );

                                await postProvider.onAddVideo(
                                  parentDialogContext,
                                );
                                Navigator.of(_2).pop();
                                Navigator.of(parentDialogContext).pop();
                              } else {
                                Fluttertoast.showToast(
                                  msg: res["message"].toString(),
                                );
                              }
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                          }

                          postProvider.setIsLoading(false);
                        },

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    verticalSpace(5),
                    Material(
                      child: ListTile(
                        title: Text(AppLocale.galleryLabel.getString(context)),
                        dense: true,
                        visualDensity: VisualDensity.compact,

                        onTap: () async {
                          postProvider.setIsLoading(true);
                          try {
                            ImagePicker imagePicker = ImagePicker();

                            var file = await imagePicker.pickVideo(
                              source: ImageSource.gallery,
                            );
                            if (file != null) {
                              var res =
                                  await CommentsController.uploadCommentVideo(
                                    File(file.path),
                                  );
                              if (res["result"] == true) {
                                postProvider.setAddMediaUrl(
                                  res["url"].toString(),
                                );

                                await postProvider.onAddVideo(
                                  parentDialogContext,
                                );
                                Navigator.of(_2).pop();
                                Navigator.of(parentDialogContext).pop();
                              } else {
                                Fluttertoast.showToast(
                                  msg: res["message"].toString(),
                                );
                              }
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                          }

                          postProvider.setIsLoading(false);
                        },

                        // onTap: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
