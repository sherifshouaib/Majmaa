import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:provider/provider.dart';

import '../providers/profile_tab_provider.dart';

void getUserImage_GetPosts_NavigationMethod(BuildContext context) {
  final profileTabProvider = Provider.of<ProfileTabProvider>(
    context,
    listen: false,
  );

  profileTabProvider.getData();
  final timelineProvider = Provider.of<TimelineProvider>(
    context,
    listen: false,
  );
  timelineProvider.getData();

  context.go(AppRouter.kHomeView);
}
