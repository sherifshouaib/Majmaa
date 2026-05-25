import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale.dart';
import '../../../../../core/utils/providers/location_viewer_provider.dart';

class ConfirmLocationsButton extends StatelessWidget {
  const ConfirmLocationsButton({
    super.key,
    required this.locationViewerProvider,
  });

  final LocationViewerProvider locationViewerProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await locationViewerProvider.setCurrentLocation();
        GoRouter.of(context).pop(locationViewerProvider.currentLocation);
      },
      child: Text(AppLocale.confirm_location_label.getString(context)),
    );
  }
}
