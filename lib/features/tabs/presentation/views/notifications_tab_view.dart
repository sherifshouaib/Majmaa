import 'package:flutter/material.dart';
class NotificationsTabView extends StatelessWidget {
  const NotificationsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Notifications Tab")),
    );
  }
}