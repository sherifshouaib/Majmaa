

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../../../core/utils/providers/location_viewer_provider.dart';

class MapBody extends StatelessWidget {
  const MapBody({
    super.key,
    required this.locationViewerProvider,
  });

  final LocationViewerProvider locationViewerProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: OSMFlutter(
        controller: locationViewerProvider.mapController,
        osmOption: OSMOption(
          // userTrackingOption: const UserTrackingOption(
          //   enableTracking: true,
          //   unFollowUser: false,
          // ),
          zoomOption: const ZoomOption(
            initZoom: 12,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_pin,
                color: Colors.blue,
                size: 60,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                color: Colors.blue,
                size: 60,
              ),
            ),
          ),
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
        ),
      ),
    );
  }
}
