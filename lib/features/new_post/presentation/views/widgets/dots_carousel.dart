

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';

class DotsCarousel extends StatelessWidget {
  const DotsCarousel({
    super.key,
    required this.newPostProvider,
    required CarouselSliderController controller,
  }) : _controller = controller;

  final NewPostProvider newPostProvider;
  final CarouselSliderController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: newPostProvider.media
          .asMap()
          .entries
          .map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(
                entry.key,
              ),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      (Theme.of(context).brightness ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withValues(
                            alpha:
                                newPostProvider
                                        .currentPhotoIndex ==
                                    entry.key
                                ? 0.9
                                : 0.4,
                          ),
                ),
              ),
            );
          })
          .toList(),
    );
  }
}
