import 'package:flutter/material.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/utils/providers/post_provider.dart';
import 'choose_media_icon.dart';
import 'comment_text_box.dart';

class WriteCommentSection extends StatelessWidget {
  const WriteCommentSection({super.key, required this.postProvider});

  final PostProvider postProvider;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: (MediaQuery.sizeOf(context).width),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.blueGrey.withValues(alpha: 0.8),

          //  .withOpacity(0.8),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            // InkWell(child: Icon(Icons.add), onTap: () {}),
            // horizontalSpace(10),
            ChooseMediaIcon(),

            horizontalSpace(10),

            Expanded(child: CommentTextBox(postProvider: postProvider)),

            horizontalSpace(10),
            if (!(postProvider.isNewCommentEmpty))
              InkWell(
                child: Icon(Icons.send),
                onTap: () async {
                  await postProvider.onAdd(context);
                },
              ),
            // InkWellSendMark(postProvider: postProvider),
          ],
        ),
      ),
    );
  }
}
