import 'package:flutter/material.dart' hide FilledButton, showDialog;
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/features/login/presentation/manager/views/widgets/update_password_view_body.dart';
import 'package:merhaba/main_development.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(AppLocale.update_password_label.getString(context)),
          ),
        ),
        body: UpdatePasswordViewBody(),
      ),
    );
  }
}
