import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';
import 'package:provider/provider.dart';

import 'current_location.dart';

class LocationOccasionShow extends StatelessWidget {
  const LocationOccasionShow({super.key});

  @override
  Widget build(BuildContext context) {
    final newPostProvider = Provider.of<NewPostProvider>(context);

    return SizedBox(
      height: 30,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        children: [
          newPostProvider.locationData.isEmpty
              ? Container()
              : CurrentLocation(),

          newPostProvider.isOccasionSelected
              ? selectedOccasion(newPostProvider, context)
              : Container(),
        ],
      ),
    );
  }

  Row selectedOccasion(NewPostProvider newPostProvider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   label: Text(
        //     newPostProvider
        //         .getOccasionsOptions(context)
        //         .firstWhere(
        //           (element) =>
        //               element["value"] == newPostProvider.selectedOccasion,
        //         )["label"]
        //         .toString(),
        //   ),
        //   icon: newPostProvider
        //       .getOccasionsOptions(context)
        //       .firstWhere(
        //         (element) =>
        //             element["value"] == newPostProvider.selectedOccasion,
        //       )["icon"],
        // ),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              newPostProvider
                  .getOccasionsOptions(context)
                  .firstWhere(
                    (element) =>
                        element["value"] == newPostProvider.selectedOccasion,
                  )["icon"],

              const SizedBox(width: 5),

              Text(
                newPostProvider
                    .getOccasionsOptions(context)
                    .firstWhere(
                      (element) =>
                          element["value"] == newPostProvider.selectedOccasion,
                    )["label"]
                    .toString(),
              ),

              const SizedBox(width: 8),

              GestureDetector(
                onTap: () {
                  context.read<NewPostProvider>().removeOccasion();
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
