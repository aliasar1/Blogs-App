import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/constants.dart';
import '../utils/strings_manager.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textformfield.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/loginScreen';

  @override
  Widget build(BuildContext context) {
    AuthenticateController controller = Get.put(AuthenticateController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.scaffoldBgColor,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Constants.marginXL, horizontal: Constants.marginXL),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.sticky_note_2,
                        color: Constants.secondaryColor,
                        size: Constants.sizeXL * 7,
                      ),
                    ),
                    const Txt(
                      text: Constants.appName,
                      color: Constants.secondaryColor,
                      fontSize: Constants.headerFontSize,
                      fontWeight: Constants.bold,
                    ),
                    const SizedBox(
                      height: Constants.sizeXL,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Txt(
                        text: StringsManager.welcomTxt,
                        textAlign: TextAlign.left,
                        color: Constants.primaryColor,
                        fontWeight: Constants.bold,
                        fontSize: Constants.titleFontSize,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Txt(
                        text: StringsManager.loginAccTxt,
                        color: Constants.primaryColor,
                        fontWeight: Constants.medium,
                        fontSize: Constants.subTitleFontSize * 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeXL,
                    ),
                    CustomTextFormField(
                      controller: controller.emailController,
                      labelText: StringsManager.emailTxt,
                      autofocus: false,
                      hintText: StringsManager.emailHintTxt,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ErrorManager.kEmailNullError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: Constants.sizeSemiM,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.passwordController,
                        autofocus: false,
                        labelText: StringsManager.passwordTxt,
                        obscureText: controller.isObscure.value,
                        prefixIconData: Icons.vpn_key_rounded,
                        suffixIconData: controller.isObscure.value
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        onSuffixTap: controller.toggleVisibility,
                        textInputAction: TextInputAction.done,
                        onFieldSubmit: (_) async {
                          await controller.login(
                              controller.emailController.text.trim(),
                              controller.passwordController.text.trim());
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ErrorManager.kPasswordNullError;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeM,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: const Txt(
                          text: StringsManager.forgotPassTxt,
                          color: Constants.primaryColor,
                          fontSize: Constants.textFontSize * 0.9,
                          fontWeight: Constants.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeXL,
                    ),
                    Obx(
                      () => CustomButton(
                        color: Constants.secondaryColor,
                        hasInfiniteWidth: true,
                        buttonType: ButtonType.loading,
                        loadingWidget: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Constants.scaffoldBgColor,
                                ),
                              )
                            : null,
                        onPressed: () async {
                          await controller.login(
                            controller.emailController.text.trim(),
                            controller.passwordController.text.trim(),
                          );
                        },
                        text: StringsManager.loginTxt,
                        textColor: Constants.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Txt(
                          text: StringsManager.noAccTxt,
                          fontSize: Constants.textFontSize,
                          color: Constants.primaryColor,
                        ),
                        InkWell(
                          onTap: () {
                            controller.clearfields();
                            Get.offAll(const SignupScreen());
                          },
                          child: const Txt(
                            text: StringsManager.registerTxt,
                            fontSize: Constants.textFontSize,
                            color: Constants.lightSecondaryColor,
                            fontWeight: Constants.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
