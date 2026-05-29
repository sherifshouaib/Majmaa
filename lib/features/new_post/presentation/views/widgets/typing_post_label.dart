import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../../../core/locale/app_locale.dart';
import '../../../../../core/utils/providers/new_post_provider.dart';

class TypingPostLabel extends StatelessWidget {
  const TypingPostLabel({super.key, required this.newPostProvider});

  final NewPostProvider newPostProvider;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(0),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hintText: AppLocale.typeSomethingLabel.getString(context),
      ),

      // minLines: 3,
      maxLines: null,
      controller: newPostProvider.textController,
    );
  }
}
