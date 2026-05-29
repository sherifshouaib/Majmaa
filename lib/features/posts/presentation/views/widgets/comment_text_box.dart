import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/post_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class CommentTextBox extends StatelessWidget {
  const CommentTextBox({super.key, required this.postProvider});

  final PostProvider postProvider;

  @override
  Widget build(BuildContext context) {
    return fluent.TextBox(
      placeholder: AppLocale.commentLabel.getString(context),
      expands: false,
      controller: postProvider.newCommentController,
      focusNode: postProvider.newCommentFocusNode,
      onChanged: (value) {
        postProvider.setIsNewCommentEmpty(value.isEmpty);
      },
    );
  }
}
