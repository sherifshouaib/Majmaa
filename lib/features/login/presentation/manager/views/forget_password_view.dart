import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/features/login/presentation/manager/views/widgets/forget_password_view_body.dart';
import 'package:merhaba/main_development.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                AppLocale.forget_password_appbar_label.getString(context),
              ),
            ),
          ),
          body: ForgetPasswordViewBody(),
        ),
      ),
    );
  }
}
