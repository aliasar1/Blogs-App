import 'package:blogs_app/utils/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textformfield.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signupScreen';

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
                key: controller.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/register.svg',
                        height: Constants.svgImageSizeMed,
                        width: Constants.svgImageSizeMed,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeXL,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Txt(
                        text: StringsManager.registerTxt,
                        textAlign: TextAlign.left,
                        color: Constants.primaryColor,
                        fontWeight: Constants.bold,
                        fontSize: Constants.titleFontSize,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Txt(
                        text: StringsManager.registerNowTxt,
                        color: Constants.primaryColor,
                        fontWeight: Constants.medium,
                        fontSize: Constants.subTitleFontSize * 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeSemiM,
                    ),
                    CustomTextFormField(
                      controller: controller.nameController,
                      labelText: StringsManager.nameTxt,
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ErrorManager.kUserNameNullError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: Constants.sizeSemiM,
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
                          await controller.signUpUser(
                            name: controller.nameController.text.trim(),
                            email: controller.emailController.text.trim(),
                            password: controller.passwordController.text.trim(),
                          );
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
                      height: Constants.sizeXL,
                    ),
                    Obx(
                      () => CustomButton(
                        color: Constants.secondaryColor,
                        hasInfiniteWidth: true,
                        loadingWidget: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Constants.scaffoldBgColor,
                                ),
                              )
                            : null,
                        onPressed: () async {
                          await controller.signUpUser(
                            name: controller.nameController.text.trim(),
                            email: controller.emailController.text.trim(),
                            password: controller.passwordController.text.trim(),
                          );
                        },
                        text: StringsManager.registerTxt,
                        textColor: Constants.whiteColor,
                        buttonType: ButtonType.loading,
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sizeL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Txt(
                          text: StringsManager.alreadyHaveAccTxt,
                          fontSize: Constants.textFontSize,
                          color: Constants.primaryColor,
                        ),
                        InkWell(
                          onTap: () {
                            controller.clearfields();
                            Get.offAll(const LoginScreen());
                          },
                          child: const Txt(
                            text: StringsManager.loginTxt,
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
