import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeTabViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTabViewAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title:
          Text(
                // AppLocale.home_label.getString(context),
                //  "MERHABA",
                "MAJMAA",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 3000.ms, color: const Color(0xFF80DDFF))
              .animate(
                // onPlay: (controller) => controller.repeat(),
              ) // this wraps the previous Animate in another Animate
              .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
              .slide(),
    );
  }
}
