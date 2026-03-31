import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  bool canResend = true;

  Future<void> sendResetEmail() async {
    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter your email");
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        emailController.text.trim(),
        redirectTo: 'io.supabase.flutter://reset-callback/',
      );

      Fluttertoast.showToast(msg: "Check your email 📩");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    setState(() => isLoading = false);
  }

  Future<void> resendEmail() async {
    if (!canResend) return;

    setState(() => canResend = false);

    await sendResetEmail();

    Future.delayed(const Duration(seconds: 30), () {
      setState(() => canResend = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: AppLocale.enter_your_email_label.getString(context),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: isLoading ? null : sendResetEmail,
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(AppLocale.send_reset_email_label.getString(context)),
          ),

          const SizedBox(height: 10),

          TextButton(
            onPressed: canResend ? resendEmail : null,
            child: Text(AppLocale.resend_email_label.getString(context)),
          ),
        ],
      ),
    );
  }
}
