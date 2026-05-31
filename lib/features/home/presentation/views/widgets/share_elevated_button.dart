import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../../../core/locale/app_locale.dart';

class ShareElevatedButton extends StatelessWidget {
  const ShareElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      label: Text(
        AppLocale.shareLabel.getString(context),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      icon: Icon(fluent.FluentIcons.share, size: 15),
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
