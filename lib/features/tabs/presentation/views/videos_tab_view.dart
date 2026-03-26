import 'package:flutter/material.dart';
class VideosTabView extends StatelessWidget {
  const VideosTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Videos Tab")),
    );
  }
}