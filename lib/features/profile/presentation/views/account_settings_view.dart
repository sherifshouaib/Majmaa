import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/account_settings_view_body.dart';
import 'package:merhaba/main_development.dart';

import '../../../../core/locale/app_locale.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.accountSettingsLabel.getString(context)),
        ),
        body: AccountSettingsViewBody(),
      ),
    );
  }
}
