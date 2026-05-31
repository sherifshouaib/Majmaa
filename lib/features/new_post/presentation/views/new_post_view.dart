import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:merhaba/core/helper/spacing.dart';

import 'package:merhaba/core/utils/providers/new_post_provider.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/new_post/presentation/views/widgets/post_resources.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/custom_profile_photo.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

import 'widgets/carousel_and_dots.dart';
import 'widgets/location_occasion_show.dart';
import 'widgets/new_post_appbar.dart';
import 'widgets/post_mode_options.dart';
import 'widgets/typing_post_label.dart';
import 'widgets/user_name_text.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  @override
  Widget build(BuildContext context) {
    final profileTabProvider = Provider.of<ProfileTabProvider>(
      context,
    //  listen: false,
    );

    final newPostProvider = Provider.of<NewPostProvider>(context);
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: NewPostAppBar(newPostProvider: newPostProvider),
        body: newPostProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      CustomProfilePhoto(
                        profileTabProvider: profileTabProvider,
                        height: 30,
                        width: 30,
                      ),
                      horizontalSpace(15),
                      SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 65) * 0.4,
                        child: UserNameText(
                          profileTabProvider: profileTabProvider,
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 65) * 0.59,
                        child: PostModeOptions(
                          newPostProvider: newPostProvider,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(5),

                  LocationOccasionShow(),

                  verticalSpace(30),
                  TypingPostLabel(newPostProvider: newPostProvider),

                  newPostProvider.media.isEmpty
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CarouselAndDots(),
                        ),
                  PostResources(),
                ],
              ),
      ),
    );
  }
}
