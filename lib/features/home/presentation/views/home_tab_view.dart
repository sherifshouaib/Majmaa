import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:merhaba/features/home/presentation/views/widgets/home_tab_view_appbar.dart';
import 'package:merhaba/features/home/presentation/views/widgets/home_tab_view_body.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLineProvider = Provider.of<TimelineProvider>(context);

    return Scaffold(
      appBar: HomeTabViewAppBar(),
      body: SwipeRefresh.adaptive(
        stateStream: timeLineProvider.swipeStream,
        onRefresh: timeLineProvider.onRefresh,
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [HomeTabViewBody()],
      ),
    );
  }
}
