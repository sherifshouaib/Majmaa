import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/providers/new_post_provider.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: Icon(Icons.location_pin),
        //   label: Text(AppLocale.locationLabel.getString(context)),
        // ),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_pin),

              const SizedBox(width: 5),

              Text(AppLocale.locationLabel.getString(context)),

              const SizedBox(width: 8),

              GestureDetector(
                onTap: () {
                  context.read<NewPostProvider>().removeLocation();
                },
                child: const Icon(Icons.close, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
