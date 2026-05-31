import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/locale/app_locale.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../../core/utils/providers/post_provider.dart';
import 'post_widget.dart';

class CommentElevatedButton extends StatelessWidget {
  const CommentElevatedButton({super.key, required this.widget});

  final PostWidget widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (widget.canNavigate) {
          final postProvider = Provider.of<PostProvider>(
            context,
            listen: false,
          );
          postProvider.setCurrentPost(widget.post);
          postProvider.getData();
          GoRouter.of(context).push(AppRouter.kPostView);
        } else {
          final postProvider = Provider.of<PostProvider>(
            context,
            listen: false,
          );

          postProvider.newCommentFocusNode.requestFocus();
        }
      },
      label: Text(
        AppLocale.commentLabel.getString(context),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
    );
  }
}
