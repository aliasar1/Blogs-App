import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Constants.scaffoldBgColor,
      ),
    );
  }
}
