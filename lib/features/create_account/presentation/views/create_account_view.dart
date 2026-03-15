import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';
import 'package:merhaba/core/utils/providers/create_account_provider.dart';
import 'package:merhaba/core/widgets/custom_info_label.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';
import 'package:merhaba/core/widgets/row_log_reg.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    fullNameController.dispose();
    confirmPassController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createAccountProvider = Provider.of<CreateAccountProvider>(context);

    return Scaffold(
      body: createAccountProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                LogoOnboardingLight(),

                CustomInfoLabel(
                  funcController: emailController,
                  label: "Enter your email",
                  placeholder: 'Email',
                ),

                verticalSpace(15),
                CustomInfoLabel(
                  funcController: fullNameController,
                  label: "Enter your Full Name",
                  placeholder: 'Full Name',
                ),

                verticalSpace(15),
                CustomInfoLabel(
                  funcController: phoneController,
                  label: "Enter your Phone",
                  placeholder: 'Phone',
                  textInputType: TextInputType.phone,
                ),

                verticalSpace(15),
                CustomInfoLabel(
                  funcController: passController,
                  label: "Enter your password",
                  placeholder: 'Password',
                  obsecure: true,
                ),

                verticalSpace(20),
                CustomInfoLabel(
                  funcController: confirmPassController,
                  label: "Confirm your password",
                  placeholder: 'Confirm Password',
                  obsecure: true,
                ),

                verticalSpace(20),

                RowLogCreateAcc(
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
                    if (confirmPassController.text == "") {
                      Fluttertoast.showToast(
                        msg: "Please confirm your password!",
                      );
                      return;
                    }

                    if (confirmPassController.text != passController.text) {
                      Fluttertoast.showToast(msg: "Passwords don't match!");
                      return;
                    }

                    if (fullNameController.text == "") {
                      Fluttertoast.showToast(
                        msg: "Please enter your full name!",
                      );
                      return;
                    }

                    createAccountProvider.toggleLoading();

                    try {
                      var res = await AuthController.createAccount({
                        "email": emailController.text.toLowerCase().trim(),
                        "password": passController.text,
                        "fullName": fullNameController.text,
                        "phone": phoneController.text,
                      });

                      if (res["result"] == true) {
                        context.pop();
                      } else {
                        Fluttertoast.showToast(msg: res["message"].toString());
                      }
                    } catch (e) {
                      print(e.toString());
                    }

                    createAccountProvider.toggleLoading();
                  },
                  textButton: 'Sign Up',
                ),
              ],
            ),
    );
  }
}
