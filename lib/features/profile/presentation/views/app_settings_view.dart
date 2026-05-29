import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/app_settings_view_body.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);

    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.appSettingsLabel.getString(context)),
        ),
        body: AppSettingsViewBody(appSettingsProvider: appSettingsProvider),
      ),
    );
  }
}
