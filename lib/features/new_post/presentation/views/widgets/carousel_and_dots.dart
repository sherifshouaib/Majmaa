import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/providers/new_post_provider.dart';
import 'dots_carousel.dart';
import 'video_post_item.dart';

class CarouselAndDots extends StatefulWidget {
  const CarouselAndDots({super.key});

  @override
  State<CarouselAndDots> createState() => _CarouselAndDotsState();
}

class _CarouselAndDotsState extends State<CarouselAndDots> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final newPostProvider = Provider.of<NewPostProvider>(context);

    return Column(
      children: [
        CarouselSlider(
          items: newPostProvider.media
              .map(
                (item) => item["type"] == "photo"
                    ? CachedNetworkImage(
                        imageUrl: item["url"].toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      )
                    : VideoPostItem(videoUrl: item["url"].toString()),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              // setState(() {
              //   _current = index;
              // });
              newPostProvider.setCurrentPhotoIndex(index);
            },
          ),
        ),
        DotsCarousel(newPostProvider: newPostProvider, controller: _controller),
      ],
    );
  }
}
