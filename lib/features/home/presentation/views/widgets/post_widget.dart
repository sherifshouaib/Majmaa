import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_empty.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.post});

  final Map<String, dynamic> post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;

  final baseUrl =
      "https://iopikpwzkhllrxvixygw.supabase.co/storage/v1/object/public/Users/";

  @override
  Widget build(BuildContext context) {
    final profileTabProvider = Provider.of<ProfileTabProvider>(
      context,
      listen: true,
    );
    final photoUpdatedAt = widget.post["user_photo_updated_at"] ?? "";

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width - 25,

                //  height: 400,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
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
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          60,
                                                        ),
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

                            // CustomProfilePhoto(
                            //   //  post: widget.post,
                            //   height: 30,
                            //   width: 30,
                            //   profileTabProvider: profileTabProvider,
                            // ),
                            horizontalSpace(15),
                            SizedBox(
                              width:
                                  (MediaQuery.sizeOf(context).width - 65) * 0.4,

                              child: Text(
                                widget.post["username"].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 20) * 0.9,
                          child: Text(
                            widget.post["parsedContent"]["text"].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(5),

                    widget.post["parsedContent"]["media"].toString() == "" ||
                            widget.post["parsedContent"]["media"].isEmpty
                        ? Container()
                        : Stack(
                            children: [
                              CarouselSlider(
                                items: (widget.post["parsedContent"]["media"] as List)
                                    .map(
                                      (item) => item["type"] == "photo"
                                          ? CachedNetworkImage(
                                              imageUrl: item["url"].toString(),
                                              imageBuilder:
                                                  (
                                                    context,
                                                    imageProvider,
                                                  ) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                        child: Icon(
                                                          Icons.error,
                                                        ),
                                                      ),
                                            )
                                          : Container(
                                              child: FlickVideoPlayer(
                                                flickManager: FlickManager(
                                                  videoPlayerController:
                                                      VideoPlayerController.networkUrl(
                                                        Uri.parse(
                                                          item["url"]
                                                              .toString(),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                    )
                                    .toList(),
                                carouselController: _controller,
                                options: CarouselOptions(
                                  autoPlay: false,
                                  enlargeCenterPage: false,
                                  aspectRatio: 2.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });

                                    //  newPostProvider.setCurrentPhotoIndex(index);
                                  },
                                  viewportFraction: 1.0,
                                ),
                              ),

                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "${currentIndex + 1}/${widget.post["parsedContent"]["media"].length}",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                    verticalSpace(5),
                    Divider(),
                    verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            AppLocale.like_label.getString(context),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: Icon(fluent.FluentIcons.like, size: 15),
                          style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(1),
                            visualDensity: VisualDensity.compact,
                            // shape: WidgetStatePropertyAll(
                            //   RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            // ),
                          ),
                        ),

                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            AppLocale.comment_label.getString(context),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: Icon(fluent.FluentIcons.comment, size: 15),
                          style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(1),
                            visualDensity: VisualDensity.compact,
                            // shape: WidgetStatePropertyAll(
                            //   RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            // ),
                          ),
                        ),

                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            AppLocale.share_label.getString(context),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: Icon(fluent.FluentIcons.share, size: 15),
                          style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(1),
                            visualDensity: VisualDensity.compact,
                            // shape: WidgetStatePropertyAll(
                            //   RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: (widget.post["parsedContent"]["media"] as List)
                    //       .asMap()
                    //       .entries
                    //       .map((entry) {
                    //         return GestureDetector(
                    //           onTap: () => _controller.animateToPage(entry.key),
                    //           child: Container(
                    //             width: 12.0,
                    //             height: 12.0,
                    //             margin: EdgeInsets.symmetric(
                    //               vertical: 8.0,
                    //               horizontal: 4.0,
                    //             ),
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color:
                    //                   (Theme.of(context).brightness ==
                    //                               Brightness.dark
                    //                           ? Colors.white
                    //                           : Colors.black)
                    //                       .withValues(
                    //                         alpha: currentIndex == entry.key
                    //                             ? 0.9
                    //                             : 0.4,
                    //                       ),
                    //             ),
                    //           ),
                    //         );
                    //       })
                    //       .toList(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
