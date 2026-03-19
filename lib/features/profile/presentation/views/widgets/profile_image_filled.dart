import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';

class ProfileImageFilled extends StatelessWidget {
  const ProfileImageFilled({
    super.key,
    required this.profileTabProvider,
  });

  final ProfileTabProvider profileTabProvider;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: profileTabProvider.photoUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(image: imageProvider),
          ),
        ),
        placeholder: (context, url) =>
            const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
  }
}

