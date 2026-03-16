import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Home Tab")),
    );
  }
}