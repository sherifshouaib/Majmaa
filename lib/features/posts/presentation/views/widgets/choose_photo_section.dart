import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhaba/core/utils/controllers/comments_controller.dart';
import 'package:merhaba/core/utils/providers/post_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/locale/app_locale.dart';
import '../../../../../main_development.dart';

class ChoosePhotoSection extends StatelessWidget {
  const ChoosePhotoSection({
    super.key,
    required this.parentDialogContext,
    // required this.sourceDialogContext,
  });

  final BuildContext parentDialogContext;
  // final BuildContext sourceDialogContext;

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Material(
      child: ListTile(
        title: Text(AppLocale.photoLabel.getString(context)),
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

                            var file = await imagePicker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 50,
                            );
                            if (file != null) {
                              var res =
                                  await CommentsController.uploadCommentImage(
                                    File(file.path),
                                  );
                              if (res["result"] == true) {
                                postProvider.setAddMedia(
                                  url: res["url"].toString(),
                                  fileName: res["fileName"].toString(),
                                );
                                // postProvider.setAddMediaUrl(
                                //   res["url"].toString(),
                                // );

                                await postProvider.onAddPhoto(
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

                            var file = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 50,
                            );
                            if (file != null) {
                              var res =
                                  await CommentsController.uploadCommentImage(
                                    File(file.path),
                                  );
                              if (res["result"] == true) {
                                postProvider.setAddMedia(
                                  url: res["url"].toString(),
                                  fileName: res["fileName"].toString(),
                                );

                                // postProvider.setAddMediaUrl(
                                //   res["url"].toString(),
                                // );

                                await postProvider.onAddPhoto(
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
