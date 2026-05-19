import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/main_development.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/helper/spacing.dart';
import '../../../../profile/presentation/views/widgets/profile_image_empty.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({super.key, required this.comment});

  Map<String, dynamic> comment = {};
  //Map<String, dynamic> post = {};

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> parsedContent = Map<String, dynamic>.from(
      jsonDecode(comment["content"]) as Map,
    );

    final photoUpdatedAt = comment["user_photo_updated_at"] ?? "";

    return Container(
      margin: localization.currentLocale.localeIdentifier == "ar"
          ? EdgeInsets.only(left: (MediaQuery.sizeOf(context).width - 60) * 0.35)
          : EdgeInsets.only(
              right: (MediaQuery.sizeOf(context).width - 60) * 0.35,
            ),
      width: (MediaQuery.sizeOf(context).width - 40) * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey.withOpacity(0.25),
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

                              //  "${localization.currentLocale.localeIdentifier}_short",
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    parsedContent["media"]["url"].toString(),
                  ),
                ),
              ),
              height: 100,
            ),
        ],
      ),
    );
  }
}
