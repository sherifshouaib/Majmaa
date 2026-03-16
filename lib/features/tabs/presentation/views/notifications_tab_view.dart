import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
class NotificationsTabView extends StatelessWidget {
  const NotificationsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Notifications Tab")),
    );
  }
}