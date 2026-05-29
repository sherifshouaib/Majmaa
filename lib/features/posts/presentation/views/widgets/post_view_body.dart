import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:merhaba/core/helper/spacing.dart';

import '../../../../../core/utils/providers/post_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:merhaba/features/home/presentation/views/widgets/post_widget.dart';
import 'package:merhaba/features/posts/presentation/views/widgets/comment_widget.dart';

import 'write_comment_section.dart';

class PostViewBody extends StatelessWidget {
  const PostViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Stack(
      children: [
        ListView(
          // mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            PostWidget(
              post: postProvider.currentPost,
              showActions: true,
              canNavigate: false,
            ),
            verticalSpace(3),

            // Comments here
            ...postProvider.comments.map(
              (comment) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: fluent.SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 60) * 0.6,
                  child: CommentWidget(
                    comment: comment,
                    //  post: postProvider.currentPost,
                  ),
                ),
              ),
            ),

            verticalSpace(100),
          ],
        ),

        WriteCommentSection(postProvider: postProvider),
      ],
    );
  }
}
