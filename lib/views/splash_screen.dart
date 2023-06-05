import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/constants.dart';
import '../widgets/custom_text.dart';

class SplashhScreen extends StatefulWidget {
  const SplashhScreen({super.key});

  @override
  State<SplashhScreen> createState() => _SplashhScreenState();
}

class _SplashhScreenState extends State<SplashhScreen> {
  final authController = Get.put(AuthenticateController());

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => authController.checkLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.sticky_note_2,
                color: Constants.whiteColor,
                size: Constants.sizeXL * 8,
              ),
              Txt(
                text: Constants.appName,
                color: Constants.whiteColor.withOpacity(0.8),
                fontSize: Constants.headerFontSize * 1.5,
                fontWeight: Constants.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
