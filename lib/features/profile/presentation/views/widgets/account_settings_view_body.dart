import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart' hide showDialog, Colors, FilledButton;
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../../core/utils/controllers/auth_controller.dart';
import 'profile_options_inkwell.dart';

class AccountSettingsViewBody extends StatelessWidget {
  const AccountSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ProfileOptionsInkWell(
            text: "Delete Account",
            color: Colors.red,
            ontap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => fluent.ContentDialog(
                  title: const Text("Delete Account"),
                  content: const Text(
                    "Are you sure? This action cannot be undone.",
                  ),
                  actions: [
                    Button(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancel"),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
          
              if (confirm != true) return;
          
              try {
                await AuthController.deleteAccount();
          
                if (context.mounted) {
                  GoRouter.of(context).go(AppRouter.kLoginView);
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
        ),
      ],
    );
  }
}
