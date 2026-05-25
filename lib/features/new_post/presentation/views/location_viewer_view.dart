import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/location_viewer_provider.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

import 'widgets/location_viewer_view_body.dart';

class LocationViewerView extends StatelessWidget {
  const LocationViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationViewerProvider = Provider.of<LocationViewerProvider>(context);
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.location_viewer_label.getString(context)),
          centerTitle: true,
        ),
        body: LocationViewerViewBody(
          locationViewerProvider: locationViewerProvider,
        ),
      ),
    );
  }
}
