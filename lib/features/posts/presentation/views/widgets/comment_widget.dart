import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/main_development.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/helper/spacing.dart';
import '../../../../profile/presentation/views/widgets/profile_image_empty.dart';
import 'package:video_player/video_player.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({super.key, required this.comment});

  Map<String, dynamic> comment = {};

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> parsedContent = Map<String, dynamic>.from(
      jsonDecode(comment["content"]) as Map,
    );

    final photoUpdatedAt = comment["user_photo_updated_at"] ?? "";

    return Container(
      margin: localization.currentLocale.localeIdentifier == "ar"
          ? EdgeInsets.only(left: (MediaQuery.sizeOf(context).width - 60) * 0.5)
          : EdgeInsets.only(
              right: (MediaQuery.sizeOf(context).width - 60) * 0.5,
            ),
      width: (MediaQuery.sizeOf(context).width - 60) * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey.withValues(alpha: 0.25),

        //.withOpacity(0.25),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (MediaQuery.sizeOf(context).width - 60) * 0.55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (comment["user_photo"] ?? "").isEmpty
                            ? ProfileImageEmpty(height: 30, width: 30)
                            : CachedNetworkImage(
                                imageUrl:
                                    "${comment["user_photo"]}?t=$photoUpdatedAt",

                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ],
                    ),

                    horizontalSpace(10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 60) * 0.2,

                          child: Text(
                            comment["username"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              //  color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 60) * 0.2,

                          child: Text(
                            timeago.format(
                              DateTime.parse(comment["date_added"].toString()),
                              locale:
                                  localization.currentLocale.localeIdentifier ==
                                      'ar'
                                  ? "ar"
                                  : localization
                                            .currentLocale
                                            .localeIdentifier ==
                                        'en'
                                  ? 'en_short'
                                  : localization.currentLocale.localeIdentifier,
                            ),
                            // widget.post["username"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[400],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          verticalSpace(10),

          if (parsedContent["text"] != "")
            Row(
              children: [
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 60) * 0.55,
                  child: Text(
                    parsedContent["text"].toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          verticalSpace(5),
          if (parsedContent["media"] != "")
            if (parsedContent["media"]["type"] == "photo")
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRouter.kPhotoViewerScreen,

                    extra: parsedContent["media"]["url"].toString(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        parsedContent["media"]["url"].toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: (MediaQuery.sizeOf(context).width - 60) * 0.6 - 10,

                  height: (MediaQuery.sizeOf(context).width - 60) * 0.6 - 10,
                ),
              )
            else if (parsedContent["media"]["type"] == "video")
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 60) * 0.6 - 10,

                  height: (MediaQuery.sizeOf(context).width - 60) * 0.6 - 10,
                  child: ClipRRect(
                    child: FlickVideoPlayer(
                      flickManager: FlickManager(
                        autoPlay: false,
                        videoPlayerController: VideoPlayerController.networkUrl(
                          Uri.parse(parsedContent["media"]["url"].toString()),
                          videoPlayerOptions: VideoPlayerOptions(
                            allowBackgroundPlayback: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
