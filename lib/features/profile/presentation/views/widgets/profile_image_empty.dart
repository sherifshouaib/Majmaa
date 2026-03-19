import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/assets_utils.dart';

class ProfileImageEmpty extends StatelessWidget {
  const ProfileImageEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(AssetsUtils.profileAvatar),
          ),
        ),
      );
  }
}
