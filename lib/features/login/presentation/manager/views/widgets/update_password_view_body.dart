import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog, FilledButton;
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePasswordViewBody extends StatefulWidget {
  const UpdatePasswordViewBody({super.key});

  @override
  State<UpdatePasswordViewBody> createState() => _UpdatePasswordViewBodyState();
}

class _UpdatePasswordViewBodyState extends State<UpdatePasswordViewBody> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    // 🔍 Validation
    if (passwordController.text.trim().isEmpty ||
        confirmController.text.trim().isEmpty) {
      await showMessage("Please fill all fields ❗");
      return;
    }

    if (passwordController.text.trim() != confirmController.text.trim()) {
      await showMessage("Passwords do not match ❌");
      return;
    }

    if (passwordController.text.trim().length < 6) {
      await showMessage("Password too weak (min 6 chars) ❌");
      return;
    }

    setState(() => isLoading = true);

    try {
      // 🔐 تحديث الباسورد
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: passwordController.text.trim()),
      );

      if (!mounted) return;

      // ✅ نجاح
      await showMessage("Password updated successfully ✅");

      // 🔄 رجوع لوجين
      if (!mounted) return;
      AppRouter.router.pushReplacement(AppRouter.kLoginView);
      // context.go('/login');
    } catch (e) {
      if (!mounted) return;

      // ❌ أخطاء Supabase
      if (e is AuthApiException) {
        if (e.code == 'same_password') {
          await showMessage("New password must be different ❌");
        } else if (e.code == 'weak_password') {
          await showMessage("Weak password ❌");
        } else {
          await showMessage("Auth error: ${e.message}");
        }
      } else {
        // ❌ أي Error تاني
        await showMessage("Unexpected error: ${e.toString()}");
      }
    }

    if (mounted) setState(() => isLoading = false);
  }

  Future<void> showMessage(String message) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: const Text("Info"),
        content: Text(message),
        actions: [
          FilledButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocale.new_password_label.getString(context),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: confirmController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocale.confirm_password_label.getString(context),
            ),
          ),
          SizedBox(height: 20),
          FilledButton(
            onPressed: isLoading ? null : updatePassword,
            child: isLoading
                ? const ProgressRing()
                : Text(AppLocale.update_label.getString(context)),
          ),
          // ElevatedButton(onPressed: updatePassword, child: Text("Update")),
        ],
      ),
    );
  }
}
