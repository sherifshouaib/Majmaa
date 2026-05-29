import 'package:flutter/material.dart';

import '../../../../../core/utils/providers/location_viewer_provider.dart';
import 'confirm_location_button.dart';
import 'map_body.dart';

class LocationViewerViewBody extends StatelessWidget {
  const LocationViewerViewBody({
    super.key,
    required this.locationViewerProvider,
  });

  final LocationViewerProvider locationViewerProvider;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        MapBody(locationViewerProvider: locationViewerProvider),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfirmLocationsButton(
              locationViewerProvider: locationViewerProvider,
            ),
          ],
        ),
      ],
    );
  }
}
