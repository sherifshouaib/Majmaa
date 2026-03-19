import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_empty.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_filled.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_options_inkwell.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/row_profile_data.dart';
import 'package:provider/provider.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileTabProvider = Provider.of<ProfileTabProvider>(context);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Profile Tab")),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileTabProvider.photoUrl == ""
                  ? ProfileImageEmpty()
                  : ProfileImageFilled(profileTabProvider: profileTabProvider),
            ],
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
          ProfileOptionsInkWell(text: "Account Settings"),
          verticalSpace(5),
          ProfileOptionsInkWell(text: "App Settings"),

          verticalSpace(5),
          ProfileOptionsInkWell(text: "Preferences"),

          verticalSpace(5),
          ProfileOptionsInkWell(text: "Privacy"),

          verticalSpace(10),
          Divider(),
          verticalSpace(10),
          ProfileOptionsInkWell(
            text: "Log Out",
            color: const Color.fromARGB(128, 255, 0, 0),
          ),
        ],
      ),
    );
  }
}
