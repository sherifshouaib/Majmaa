import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
class VideosTabView extends StatelessWidget {
  const VideosTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: true,title:  Text(AppLocale.videos_label.getString(context))),
    );
  }
}