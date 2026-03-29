import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/globals.dart';
import 'package:merhaba/core/utils/providers/bottom_navbar_view_provider.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/home/presentation/views/home_tab_view.dart';
import 'package:merhaba/features/profile/presentation/views/profile_tab_view.dart';
import 'package:merhaba/features/tabs/presentation/views/friends_tab_view.dart';
import 'package:merhaba/features/tabs/presentation/views/notifications_tab_view.dart';
import 'package:merhaba/features/tabs/presentation/views/videos_tab_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavBarViewBody extends StatelessWidget {
  const BottomNavBarViewBody({
    super.key,
    required PersistentTabController controller,
    required this.bottomNavBarViewProvider,
  }) : _controller = controller;

  final PersistentTabController _controller;
  final BottomNavBarViewProvider bottomNavBarViewProvider;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        HomeTabView(),
        FriendsTabView(),
        VideosTabView(),
        NotificationsTabView(),
        ProfileTabView(),
      ],
      onItemSelected: (value) {
        if (value == 4) {
          final profileTabProvider = Provider.of<ProfileTabProvider>(
            context,
            listen: false,
          );
          profileTabProvider.getData();
        }
      },
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: (AppLocale.home_label.getString(context)),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: Globals.theme == "Dark"
              ? CupertinoColors.systemGrey
              : CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.group),
          title: (AppLocale.friends_label.getString(context)),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: Globals.theme == "Dark"
              ? CupertinoColors.systemGrey
              : CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.video_camera_solid),
          title: (AppLocale.videos_label.getString(context)),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: Globals.theme == "Dark"
              ? CupertinoColors.systemGrey
              : CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.notifications),
          title: (AppLocale.notifications_label.getString(context)),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: Globals.theme == "Dark"
              ? CupertinoColors.systemGrey
              : CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_sharp),
          title: (AppLocale.profile_label.getString(context)),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: Globals.theme == "Dark"
              ? CupertinoColors.systemGrey
              : CupertinoColors.white,
        ),
      ],
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Globals.theme == "Dark"
          ? Colors.grey.shade900
          : Colors.blueGrey,
      isVisible: bottomNavBarViewProvider.isVisible,
      // animationSettings: const NavBarAnimationSettings(
      //   navBarItemAnimation: ItemAnimationSettings(
      //     // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 100),
      //     curve: Curves.ease,
      //   ),
      //   screenTransitionAnimation: ScreenTransitionAnimationSettings(
      //     // Screen transition animation on change of selected tab.
      //     animateTabTransition: true,
      //     duration: Duration(milliseconds: 100),
      //     screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
      //   ),
      // ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style14, // Choose the nav bar style with this property
    );
  }
}
