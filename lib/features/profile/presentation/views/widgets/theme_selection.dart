import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({
    super.key,
    required this.appSettingsProvider,
  });

  final AppSettingsProvider appSettingsProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: CupertinoSwitch(
        value: appSettingsProvider.isDark,
        onChanged: (bool value) {
          appSettingsProvider.updateDarkMode(value,context);
        },
        activeColor: CupertinoColors.activeGreen,
      ),
    );
  }
}

