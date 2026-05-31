import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/helper/spacing.dart';
import '../../../../../main_development.dart';
import '../../../../profile/presentation/views/widgets/profile_image_empty.dart';
import 'post_widget.dart';

class UpperBodyOfPost extends StatelessWidget {
  const UpperBodyOfPost({super.key, required this.widget});

  final PostWidget widget;

  @override
  Widget build(BuildContext context) {
    final photoUpdatedAt = widget.post["user_photo_updated_at"] ?? "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // widget.post["user_photo"] == ""
                (widget.post["user_photo"] ?? "").isEmpty
                    ? ProfileImageEmpty(height: 30, width: 30)
                    : CachedNetworkImage(
                        imageUrl:
                            "${widget.post["user_photo"]}?t=$photoUpdatedAt",
                        //  "$baseUrl/${widget.post["user_id"]}.jpg?t=${widget.post["date_updated"]}",

                        //  "${widget.post["user_photo"]}?t=${DateTime.now().millisecondsSinceEpoch}",

                        // widget.post["user_photo"],
                        imageBuilder: (context, imageProvider) => Container(
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ],
            ),

            horizontalSpace(10),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 65) * 0.4,

                  child: Text(
                    widget.post["username"].toString(),
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
                  width: (MediaQuery.sizeOf(context).width - 65) * 0.4,

                  child: Text(
                    timeago.format(
                      DateTime.parse(widget.post["date_added"].toString()),
                      locale:
                          localization.currentLocale.localeIdentifier == 'ar'
                          ? "ar"
                          : localization.currentLocale.localeIdentifier == 'en'
                          ? 'en_short'
                          : localization.currentLocale.localeIdentifier,
                    ),
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

        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
      ],
    );
  }
}
