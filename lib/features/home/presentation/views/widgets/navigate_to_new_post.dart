import 'package:flutter/material.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helper/spacing.dart';
import 'navigation_text.dart';

class NavigateToNewPostWidget extends StatelessWidget {
  const NavigateToNewPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final profileTabProvider = Provider.of<ProfileTabProvider>(
          context,
          listen: false,
        );

        await profileTabProvider.getData();
        AppRouter.router.push(AppRouter.kNewPostView);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withValues(alpha: 0.05),

          //.withOpacity(0.05),
        ),

        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [NavigationText(), const Icon(Icons.photo)],
            ),

            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
