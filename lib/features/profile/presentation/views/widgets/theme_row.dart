import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/theme_field.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/theme_selection.dart';

class ThemeRow extends StatelessWidget {
  const ThemeRow({super.key, required this.appSettingsProvider});

  final AppSettingsProvider appSettingsProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ThemeField(),

        ThemeSelection(appSettingsProvider: appSettingsProvider),
      ],
    );
  }
}
