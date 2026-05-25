import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';

class NavigationText extends StatelessWidget {
  const NavigationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 60) * 0.6,
      child: Text(
        AppLocale.whats_on_your_mind_label.getString(context),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //  fontStyle: FontStyle.italic,
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
