import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/main_development.dart';

import 'widgets/post_view_body.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(AppLocale.postLabel.getString(context)),
          ),
          body: PostViewBody(),
        ),
      ),
    );
  }
}
