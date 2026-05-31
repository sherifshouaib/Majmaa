import 'package:flutter/material.dart';

import 'post_widget.dart';

class PostText extends StatelessWidget {
  const PostText({super.key, required this.widget});

  final PostWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 20) * 0.9,
          child: Text(
            widget.post["parsedContent"]["text"].toString(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
