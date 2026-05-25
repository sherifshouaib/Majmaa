import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/utils/providers/new_post_provider.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/controllers/posts_controller.dart';
import 'dart:io';

import 'list_tile_location_viewer.dart';
import 'list_tile_occasion_selection.dart';

class PostResourcesBody extends StatelessWidget {
  const PostResourcesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final newPostProvider = Provider.of<NewPostProvider>(context);

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        ListTile(
          dense: true,
          trailing: const Icon(Icons.photo),
          onTap: () async {
            await showDialog<String>(
              context: context,
              builder: (context) => fluent.ContentDialog(
                actions: [
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.purple),
                    ),
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      var file = await imagePicker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 50,
                      );
                      if (file == null) {
                        Navigator.of(context).pop();
                        return;
                      }

                      await uploadMedia(
                        file: file,
                        type: "photo",
                        newPostProvider: newPostProvider,
                      );
                      Navigator.of(context).pop();
                    },

                    child: Text(AppLocale.camera_label.getString(context)),
                  ),
                  FilledButton(
                    child: Text(AppLocale.gallery_label.getString(context)),
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      var files = await imagePicker.pickMultiImage(
                        imageQuality: 50,
                      );

                      for (var file in files) {
                        await uploadMedia(
                          file: file,
                          type: "photo",
                          newPostProvider: newPostProvider,
                        );
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },

          title: Text(
            AppLocale.photo_label.getString(context),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        verticalSpace(5),
        ListTile(
          dense: true,
          trailing: const Icon(Icons.video_camera_back),
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (context) => fluent.ContentDialog(
                actions: [
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.purple),
                    ),
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      var file = await imagePicker.pickVideo(
                        source: ImageSource.camera,
                      );
                      if (file == null) {
                        Navigator.of(context).pop();
                        return;
                      }
                      //  debugPrint("Photo >>>>>>>>>>>>>${file.name}");

                      await uploadMedia(
                        file: file,
                        type: "video",
                        newPostProvider: newPostProvider,
                      );

                      Navigator.of(context).pop();
                    },

                    child: Text(AppLocale.camera_label.getString(context)),
                  ),
                  FilledButton(
                    child: Text(AppLocale.gallery_label.getString(context)),
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      var file = await imagePicker.pickVideo(
                        source: ImageSource.gallery,
                      );
                      if (file == null) {
                        Navigator.of(context).pop();
                        return;
                      }
                      //  debugPrint("Photo >>>>>>>>>>>>>${file.name}");
                      await uploadMedia(
                        file: file,
                        type: "video",
                        newPostProvider: newPostProvider,
                      );
                      // await UploadMedia4(file, newPostProvider);

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
          title: Text(
            AppLocale.video_label.getString(context),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),

        verticalSpace(5),

        ListTileLocationViewer(newPostProvider: newPostProvider),

        verticalSpace(5),
        ListTileOccasionSelection(),
      ],
    );
  }

  Future<void> uploadMedia({
    required XFile file,
    required String type,
    required NewPostProvider newPostProvider,
  }) async {
    var uploadRes = await PostsController.uploadPostMedia(File(file.path));
    debugPrint(uploadRes.toString());

    if (uploadRes["result"] == true) {
      newPostProvider.addNewMedia({
        "type": type,
        "url": uploadRes["url"],
        "fileName": uploadRes["fileName"],
      });
    } else {
      Fluttertoast.showToast(msg: uploadRes["message"].toString());
    }
  }
}
