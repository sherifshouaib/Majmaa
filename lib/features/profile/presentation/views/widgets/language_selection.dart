import 'package:fluent_ui/fluent_ui.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({
    super.key,
    required this.appSettingsProvider,
  });

  final AppSettingsProvider appSettingsProvider;

  @override
  Widget build(BuildContext context) {
    return ComboBox<String>(
      value: appSettingsProvider.currentLanguage,
      items: ["English", "العربية"].map((e) {
        return ComboBoxItem(value: e, child: Text(e));
      }).toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        appSettingsProvider.updateCurrentLanguage(value);
      },
    );
  }
}
