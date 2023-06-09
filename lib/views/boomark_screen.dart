import 'package:blogs_app/controllers/auth_controller.dart';
import 'package:blogs_app/controllers/blog_controller.dart';
import 'package:blogs_app/models/blog_model.dart';
import 'package:blogs_app/utils/constants.dart';
import 'package:blogs_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/blog_card.dart';
import '../widgets/custom_text.dart';

class BookmarkSrceen extends StatelessWidget {
  BookmarkSrceen({super.key});

  final controller = Get.put(BlogController());
  final authController = Get.put(AuthenticateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.scaffoldBgColor,
        drawer: CustomDrawer(controller: authController),
        appBar: AppBar(
          backgroundColor: Constants.scaffoldBgColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Constants.secondaryColor),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: Constants.marginL),
          child: Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Txt(
                    textAlign: TextAlign.start,
                    text: "Bookmarks",
                    fontWeight: Constants.bold,
                    fontSize: Constants.headerFontSize,
                    color: Constants.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                StreamBuilder<List<Blog>>(
                  stream: controller
                      .fetchFavoriteBlogs(firebaseAuth.currentUser!.uid)
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final favBlogs = snapshot.data!;
                      if (favBlogs.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: favBlogs.length,
                            itemBuilder: (ctx, i) {
                              final blog = favBlogs[i];
                              return BlogCard(
                                blog: blog,
                                isBookmarkRoute: true,
                                isBookmark: true,
                              );
                            },
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: Txt(
                              text: "No blogs are bookmarked.",
                              textAlign: TextAlign.center,
                              fontWeight: Constants.regular,
                              fontSize: Constants.textFontSize,
                              color: Constants.primaryColor,
                            ),
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Constants.secondaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
