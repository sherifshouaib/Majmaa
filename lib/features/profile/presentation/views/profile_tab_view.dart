import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Profile Tab")),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [

        ],
      ),
    );
  }
}
