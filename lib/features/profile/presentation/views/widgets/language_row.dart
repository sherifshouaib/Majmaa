import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/language_field.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/language_selection.dart';

class LanguageRow extends StatelessWidget {
  const LanguageRow({super.key, required this.appSettingsProvider});

  final AppSettingsProvider appSettingsProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LanguageField(),

        LanguageSelection(appSettingsProvider: appSettingsProvider),
      ],
    );
  }
}