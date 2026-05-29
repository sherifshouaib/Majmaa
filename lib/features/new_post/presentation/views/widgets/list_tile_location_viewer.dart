import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/location_viewer_provider.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';
import 'package:provider/provider.dart';

class ListTileLocationViewer extends StatelessWidget {
  const ListTileLocationViewer({super.key, required this.newPostProvider});

  final NewPostProvider newPostProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      trailing: const Icon(Icons.location_pin),
      onTap: () async {
        await GoRouter.of(context).push(AppRouter.klocationViewerView);

        final locationViewerProvider = Provider.of<LocationViewerProvider>(
          context,
          listen: false,
        );

        if (locationViewerProvider.currentLocation.latitude != 0 &&
            locationViewerProvider.currentLocation.longitude != 0) {
          newPostProvider.setLocationData(
            locationViewerProvider.currentLocation.toMap(),
          );
        }
      },
      title: Text(
        AppLocale.locationLabel.getString(context),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
