import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:merhaba/features/home/presentation/views/widgets/post_widget.dart';
import 'package:provider/provider.dart';

import 'navigate_to_new_post.dart';

class HomeTabViewBody extends StatelessWidget {
  const HomeTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLineProvider = Provider.of<TimelineProvider>(context);
    return ListView(
      padding: const EdgeInsets.only(bottom: 5),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        NavigateToNewPostWidget(),

        Container(
          height: 2,
          color: const Color(0x8080DDFF),
          margin: const EdgeInsets.symmetric(vertical: 5),
        ).animate().scale(duration: 1200.ms, alignment: Alignment.centerLeft),
        ...timeLineProvider.posts.map((post) {
          post["parsedContent"] = Map<String, dynamic>.from(
            jsonDecode(post["content"]) as Map,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.1),
            child: PostWidget(post: post),
          );
        }),
      ],
    );
  }
}
