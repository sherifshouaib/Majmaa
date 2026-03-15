import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';
import 'package:merhaba/core/utils/providers/login_provider.dart';
import 'package:merhaba/core/widgets/custom_info_label.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';
import 'package:merhaba/core/widgets/row_log_reg.dart';
import 'package:merhaba/core/widgets/row_text_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: loginProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                LogoOnboardingLight(),

                verticalSpace(20),

                CustomInfoLabel(
                  funcController: emailController,
                  label: "Enter your email",
                  placeholder: 'Email',
                ),
                verticalSpace(15),

                CustomInfoLabel(
                  funcController: passController,
                  label: "Enter your password",
                  placeholder: 'Password',
                  obsecure: true,
                ),

                verticalSpace(20),
                RowLogCreateAcc(
                  textButton: 'Login',
                  onPressed: () async {
                    if (emailController.text == "") {
                      Fluttertoast.showToast(msg: "Please enter your email!");
                      return;
                    }

                    if (passController.text == "") {
                      Fluttertoast.showToast(
                        msg: "Please enter your password!",
                      );
                      return;
                    }

                    loginProvider.toggleLoading();

                    try {
                      var res = await AuthController.login(
                        emailController.text,
                        passController.text,
                      );

                      if (res["result"] == true) {
                        context.go(AppRouter.kHomeView);
                      } else {
                        Fluttertoast.showToast(msg: res["message"].toString());
                      }
                    } catch (e) {
                      print(e.toString());
                    }

                    loginProvider.toggleLoading();
                  },
                ),

                verticalSpace(10),
                RowTextButton(buttonText: "Create Account"),
              ],
            ),
    );
  }
}
