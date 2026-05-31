import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:video_player/video_player.dart';

import 'post_widget.dart';

class PostMedia extends StatefulWidget {
  const PostMedia({super.key, required this.widget});
  final PostWidget widget;

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia> {
 final CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: (widget.widget.post["parsedContent"]["media"] as List)
              .map(
                (item) => item["type"] == "photo"
                    ? CachedNetworkImage(
                        imageUrl: item["url"].toString(),
                        imageBuilder: (context, imageProvider) => InkWell(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kPhotoViewerScreen,

                              extra: item["url"].toString(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      )
                    : Container(
                        child: FlickVideoPlayer(
                          flickManager: FlickManager(
                            autoPlay: false,
                            videoPlayerController:
                                VideoPlayerController.networkUrl(
                                  Uri.parse(item["url"].toString()),
                                  videoPlayerOptions: VideoPlayerOptions(
                                    allowBackgroundPlayback: false,
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
                color: Colors.black.withValues(alpha: 0.8),

                //   .withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                "${currentIndex + 1}/${widget.widget.post["parsedContent"]["media"].length}",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
