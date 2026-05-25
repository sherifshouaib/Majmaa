import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';

import '../../../../../core/helper/spacing.dart';

class PostModeOptions extends StatelessWidget {
  const PostModeOptions({super.key, required this.newPostProvider});

  final NewPostProvider newPostProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DropdownButton<String>(
          isDense: true,
          underline: Container(),
          value: newPostProvider.currentPostMode,
          onChanged: (String? value) {
            if (value == null) return;
            newPostProvider.setCurrentPostMode(value);
          },
          items: newPostProvider
              .getVisibilityOptions(context)
              .map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
                return DropdownMenuItem<String>(
                  value: value["value"],
                  child: Row(
                    children: [
                      value['icon'],

                      horizontalSpace(10),
                      Text(value['label']),
                    ],
                  ),
                );
              })
              .toList(),
        ),
      ],
    );
  }
}
