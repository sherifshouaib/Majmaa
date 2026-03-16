import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/bottom_navbar_view_provider.dart';
import 'package:merhaba/features/tabs/presentation/views/widgets/bottom_navbar_view_body.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';

class BottomNavBarView extends StatelessWidget {
  BottomNavBarView({super.key});

  final PersistentTabController _controller = PersistentTabController();
  @override
  Widget build(BuildContext context) {
    final bottomNavBarViewProvider = Provider.of<BottomNavBarViewProvider>(
      context,
    );

    return PopScope(
      canPop: false,
      child: BottomNavBarViewBody(
        controller: _controller,
        bottomNavBarViewProvider: bottomNavBarViewProvider,
      ),
    );
  }
}
