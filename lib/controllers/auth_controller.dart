import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constants.dart';
import '../models/user_model.dart' as model;
import '../views/home_screen.dart';
import '../views/login_screen.dart';

class AuthenticateController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  Rx<bool> isObscure = true.obs;
  Rx<bool> isLoading = false.obs;

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> login(String email, String password) async {
    try {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        toggleLoading();

        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        toggleLoading();
        Get.offAll(const HomeScreen());
      }
    } catch (err) {
      toggleLoading();
      Get.snackbar(
        'Error Logging in',
        err.toString(),
      );
    }
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (signupFormKey.currentState!.validate()) {
        signupFormKey.currentState!.save();
        toggleLoading();
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.User user = model.User(
          name: name,
          uid: cred.user!.uid,
          email: email,
          profilePhoto: "",
        );

        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        toggleLoading();

        Get.snackbar(
          'Success!',
          'Account created successfully.',
        );
        Get.offAll(const HomeScreen());

        clearfields();
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  Future<void> checkLoginStatus() async {
    firebaseAuth.idTokenChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(const LoginScreen());
      } else {
        Get.offAll(const HomeScreen());
      }
    });
  }

  void logout() async {
    await firebaseAuth.signOut();
  }

  void clearfields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    addressController.clear();
  }
}
