import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/app_settings_view_body.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/language_field.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/language_row.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/language_selection.dart';
import 'package:provider/provider.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("App Settings")),
      body: AppSettingsViewBody(appSettingsProvider: appSettingsProvider),
    );
  }
}

