
import 'package:flutter/material.dart';

import '../../../../../core/utils/providers/profile_tab_provider.dart';

class UserNameText extends StatelessWidget {
  const UserNameText({super.key, required this.profileTabProvider});

  final ProfileTabProvider profileTabProvider;

  @override
  Widget build(BuildContext context) {
    return Text(
      profileTabProvider.username,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
