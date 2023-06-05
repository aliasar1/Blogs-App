import 'package:blogs_app/views/home_screen.dart';
import 'package:blogs_app/views/myblogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../utils/constants.dart';
import '../views/login_screen.dart';
import '../views/profile_screen.dart';
import 'custom_text.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.controller});

  final AuthenticateController controller;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(firebaseAuth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.user.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Constants.secondaryColor,
            ),
          );
        } else {
          return Drawer(
            backgroundColor: Constants.scaffoldBgColor,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    backgroundColor: Constants.lightSecondaryColor,
                    backgroundImage: controller.user['profilePhoto'] == ""
                        ? const NetworkImage(
                            'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
                        : NetworkImage(
                            controller.user['profilePhoto'],
                          ),
                    radius: 70,
                  ),
                  const SizedBox(height: 10),
                  Txt(
                    text: controller.user['name'],
                    fontWeight: Constants.bold,
                    fontSize: Constants.titleFontSize,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  buildDrawerTile("Profile", Icons.person, () {
                    Get.offAll(const ProfileScreen());
                  }),
                  buildDrawerTile(
                    "All Blogs",
                    Icons.library_books,
                    () {
                      Get.offAll(const HomeScreen());
                    },
                  ),
                  buildDrawerTile(
                    "My Blogs",
                    Icons.sticky_note_2,
                    () {
                      Get.offAll(MyBlogsScreen());
                    },
                  ),
                  buildDrawerTile(
                    "Bookmarks",
                    Icons.bookmark,
                    () {},
                  ),
                  buildDrawerTile("Logout", Icons.logout, () {
                    buildLogoutDialog(context);
                  }),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<dynamic> buildLogoutDialog(BuildContext context) {
    return Get.dialog(
      AlertDialog(
        title: const Text(
          'Confirm Logout',
          style: TextStyle(
            color: Constants.primaryColor,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: Constants.primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Constants.secondaryColor),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Constants.secondaryColor),
            ),
            onPressed: () async {
              widget.controller.logout();
              Get.offAll(const LoginScreen());
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Constants.scaffoldBgColor),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerTile(String text, IconData icon, Function onPressed) {
    return ListTile(
      title: Txt(
        text: text,
        fontSize: Constants.subTitleFontSize,
      ),
      leading: Icon(
        icon,
        color: Constants.secondaryColor,
      ),
      onTap: () => onPressed(),
    );
  }
}
