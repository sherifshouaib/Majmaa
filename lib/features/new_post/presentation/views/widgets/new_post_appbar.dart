import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';

class NewPostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewPostAppBar({super.key, required this.newPostProvider});

  final NewPostProvider newPostProvider;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          AppRouter.router.pop();
        },
        icon: Icon(Icons.close),
      ),
      centerTitle: true,
      actions: [
        ElevatedButton(
          onPressed: () {
            newPostProvider.onAdd(context);
          },
          child: Text(AppLocale.save_label.getString(context)),
        ),
      ],
      title: Text(AppLocale.new_post_label.getString(context)),
    );
  }
}
