import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/custom_profile_photo.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_empty.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_filled.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_options_inkwell.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/row_profile_data.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileTabProvider = Provider.of<ProfileTabProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Profile Tab")),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            verticalSpace(20),
            InkWell(
              onTap: () async {
                await showDialog<String>(
                  context: context,
                  builder: (context) => fluent.ContentDialog(
                    title: const Text('Change Profile Picture ?'),
                    content: const Text(
                      'Choose the source that you want to get the new picture from',
                    ),
                    actions: [
                      FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.purple,
                          ),
                        ),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          var file = await imagePicker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                          );
                          if (file != null) {
                            //    profileTabProvider.toggleLoading();
                            try {
                              String originalFilename = path.basename(
                                file.path,
                              );
                              String extension = path.extension(file.path);
                              String fileName =
                                  "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";
                              //  print(fileName);

                              final String fullPath = await Supabase
                                  .instance
                                  .client
                                  .storage
                                  .from('Users')
                                  .upload(fileName, File(file.path));

                              final String url = await Supabase
                                  .instance
                                  .client
                                  .storage
                                  .from("Users")
                                  .getPublicUrl(fileName);
                              await profileTabProvider.updateUserProfilePicture(
                                url,
                              );
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e.toString());
                            }
                            // profileTabProvider.toggleLoading();
                          }
                        },
                        child: Text('Camera'),
                      ),
                      FilledButton(
                        child: const Text('Gallery'),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          var file = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 50,
                          );
                          if (file != null) {
                            //    profileTabProvider.toggleLoading();
                            try {
                              String originalFilename = path.basename(
                                file.path,
                              );
                              String extension = path.extension(file.path);
                              String fileName =
                                  "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";
                              //  print(fileName);

                              final String fullPath = await Supabase
                                  .instance
                                  .client
                                  .storage
                                  .from('Users')
                                  .upload(fileName, File(file.path));

                              final String url = await Supabase
                                  .instance
                                  .client
                                  .storage
                                  .from("Users")
                                  .getPublicUrl(fileName);
                              await profileTabProvider.updateUserProfilePicture(
                                url,
                              );
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e.toString());
                            }
                            // profileTabProvider.toggleLoading();
                          }
                        },
                      ),
                    ],
                  ),
                );
             
             
              },
              child: CustomProfilePhoto(profileTabProvider: profileTabProvider),
            ),

            verticalSpace(20),
            RowProfileData(
              profileTabProvider: profileTabProvider,
              text: profileTabProvider.username,
              color: Colors.grey,
              fontsize: 18,
            ),

            verticalSpace(10),

            RowProfileData(
              profileTabProvider: profileTabProvider,
              text: profileTabProvider.email,
              fontsize: 16,
            ),

            verticalSpace(10),
            RowProfileData(
              profileTabProvider: profileTabProvider,
              text: profileTabProvider.phone,
              color: Colors.grey,
              fontsize: 14,
            ),

            verticalSpace(10),
            Divider(),
            verticalSpace(10),
            ProfileOptionsInkWell(text: "Account Settings", ontap: () {}),
            verticalSpace(5),
            ProfileOptionsInkWell(
              text: "App Settings",
              ontap: () {
                GoRouter.of(context).push(AppRouter.kAppSettingsView);
              },
            ),

            verticalSpace(5),
            ProfileOptionsInkWell(text: "Preferences", ontap: () {}),

            verticalSpace(5),
            ProfileOptionsInkWell(text: "Privacy", ontap: () {}),

            verticalSpace(10),
            Divider(),
            verticalSpace(10),
            ProfileOptionsInkWell(
              text: "Log Out",
              color: const Color.fromARGB(128, 255, 0, 0),
              ontap: () async {
                try {
                  await AuthController.logOut();
                } catch (e) {
                  print(e.toString());
                }
                GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
              },
            ),
          ],
        ),
      ),
    );
  }
}

