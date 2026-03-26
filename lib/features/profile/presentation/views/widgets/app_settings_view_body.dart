import 'package:flutter/cupertino.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/language_row.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/theme_row.dart';

class AppSettingsViewBody extends StatelessWidget {
  const AppSettingsViewBody({super.key, required this.appSettingsProvider});

  final AppSettingsProvider appSettingsProvider;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        LanguageRow(appSettingsProvider: appSettingsProvider),
        verticalSpace(10),
        ThemeRow(appSettingsProvider: appSettingsProvider),
      ],
    );
  }
}
