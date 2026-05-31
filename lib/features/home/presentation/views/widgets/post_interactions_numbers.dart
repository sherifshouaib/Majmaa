import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../../../core/locale/app_locale.dart';
import 'post_widget.dart';

class PostInteractionsNumbers extends StatelessWidget {
  const PostInteractionsNumbers({
    super.key,
    required this.reactions,
    required this.widget,
  });

  final List<Map<String, dynamic>> reactions;
  final PostWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 60) * 0.33,

          child: Text(
            "${reactions.length} ${AppLocale.reactionsLabel.getString(context)}",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 60) * 0.33,

          child: Text(
            "${widget.post["commentsCount"] ?? 0} ${AppLocale.commentsLabel.getString(context)}",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 60) * 0.33,

          child: Text(
            "0 ${AppLocale.sharesLabel.getString(context)}",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
