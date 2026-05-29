import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';

class LanguageField extends StatelessWidget {
  const LanguageField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 60) * 0.45,
      child: Text(
        AppLocale.languageLabel.getString(context),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
