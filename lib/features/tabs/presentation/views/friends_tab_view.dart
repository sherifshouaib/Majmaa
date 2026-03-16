import 'package:flutter/material.dart';

class FriendsTabView extends StatelessWidget {
  const FriendsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Friends Tab")),
    );
  }
}