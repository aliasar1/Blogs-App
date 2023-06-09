import 'package:blogs_app/controllers/blog_controller.dart';
import 'package:blogs_app/utils/extensions.dart';
import 'package:blogs_app/views/add_blog_screen.dart';
import 'package:blogs_app/views/boomark_screen.dart';
import 'package:blogs_app/views/home_screen.dart';
import 'package:blogs_app/views/myblogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../models/blog_model.dart';
import '../utils/constants.dart';
import '../widgets/custom_text.dart';

class BlogOverviewScreen extends StatelessWidget {
  BlogOverviewScreen(
      {super.key,
      required this.blog,
      this.isHomePageRoute = false,
      this.isBookmarkRoute = false});

  final Blog blog;
  final bool isHomePageRoute;
  final bool isBookmarkRoute;
  final controller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.scaffoldBgColor,
        appBar: AppBar(
          title: Txt(
            text: blog.title.capitalizeFirstOfEach,
            textAlign: TextAlign.start,
            fontWeight: Constants.bold,
            color: Constants.primaryColor,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Constants.secondaryColor,
            ),
            onPressed: () {
              if (isBookmarkRoute) {
                Get.offAll(BookmarkSrceen());
              } else if (isHomePageRoute) {
                Get.offAll(const HomeScreen());
              } else {
                Get.offAll(MyBlogsScreen());
              }
            },
          ),
          backgroundColor: Constants.scaffoldBgColor,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Constants.secondaryColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: Constants.marginM, horizontal: Constants.marginM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Txt(
                  text: blog.description.capitalizeFirstOfEach,
                  textAlign: TextAlign.start,
                  fontWeight: Constants.regular,
                  fontSize: Constants.subTitleFontSize,
                  color: Constants.primaryColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Txt(
                    text: "By: ${blog.authorName.capitalizeFirstOfEach}",
                    textAlign: TextAlign.start,
                    fontWeight: Constants.bold,
                    fontSize: Constants.titleFontSize,
                    color: Constants.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: isHomePageRoute || isBookmarkRoute
            ? null
            : SpeedDial(
                animatedIcon: AnimatedIcons.menu_close,
                backgroundColor: Constants.secondaryColor,
                activeBackgroundColor: Constants.secondaryColor,
                overlayOpacity: 0,
                children: [
                  SpeedDialChild(
                    child: const Icon(
                      Icons.delete,
                      color: Constants.lightSecondaryColor,
                    ),
                    onTap: () => {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Constants.scaffoldBgColor,
                          title: const Text('Confirm Delete Blog'),
                          content: const Text(
                            'Are you sure you want to delete the blog?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'Cancel',
                                style:
                                    TextStyle(color: Constants.secondaryColor),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Constants.secondaryColor)),
                              onPressed: () async {
                                controller.deleteBlog(blog.id);
                                Get.offAll(MyBlogsScreen());
                              },
                              child: const Text(
                                'Delete',
                                style:
                                    TextStyle(color: Constants.backgroundColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(
                      Icons.edit,
                      color: Constants.lightSecondaryColor,
                    ),
                    onTap: () {
                      Get.to(AddBlogScreen(
                        isEdit: true,
                        blog: blog,
                      ));
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
