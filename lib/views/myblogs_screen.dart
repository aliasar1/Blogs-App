import 'package:blogs_app/controllers/blog_controller.dart';

import 'package:blogs_app/views/add_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart' as ctrl;
import '../controllers/auth_controller.dart';
import '../utils/constants.dart';
import '../utils/strings_manager.dart';
import '../widgets/blog_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_search.dart';
import '../widgets/custom_text.dart';

class MyBlogsScreen extends StatefulWidget {
  MyBlogsScreen({super.key});

  @override
  State<MyBlogsScreen> createState() => _MyBlogsScreenState();
}

class _MyBlogsScreenState extends State<MyBlogsScreen> {
  final controller = Get.put(AuthenticateController());

  final ctrl.SearchController searchController =
      Get.put(ctrl.SearchController());

  final blogController = Get.put(BlogController());

  @override
  void dispose() {
    Get.delete<ctrl.SearchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: Constants.scaffoldBgColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Constants.secondaryColor),
        ),
        drawer: CustomDrawer(controller: controller),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: Constants.marginL),
          child: Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Txt(
                    textAlign: TextAlign.start,
                    text: StringsManager.myBlogsTxt,
                    fontWeight: Constants.bold,
                    fontSize: Constants.headerFontSize,
                    color: Constants.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                CustomSearchWidget(
                  onFieldSubmit: (value) {
                    searchController.searchBlog(value.trim());
                  },
                ),
                const SizedBox(height: 12),
                Obx(
                  () {
                    if (blogController.isLoading.value) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Constants.secondaryColor,
                          ),
                        ),
                      );
                    } else if (searchController.searchedBlogs.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: searchController.searchedBlogs.length,
                          itemBuilder: (ctx, i) {
                            final blog = searchController.searchedBlogs[i];
                            return blog.authorId ==
                                    firebaseAuth.currentUser!.uid
                                ? BlogCard(blog: blog)
                                : Container();
                          },
                        ),
                      );
                    } else if (blogController.myBlogs.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Txt(
                            text: "You haven't added any blog.",
                            textAlign: TextAlign.center,
                            fontWeight: Constants.regular,
                            fontSize: Constants.textFontSize,
                            color: Constants.primaryColor,
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: blogController.myBlogs.length,
                          itemBuilder: (ctx, i) {
                            final blog = blogController.myBlogs[i];
                            return BlogCard(
                              blog: blog,
                              isMyBlogsRoute: true,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(const AddBlogScreen());
            },
            backgroundColor: Constants.secondaryColor,
            child: const Icon(
              Icons.add,
              color: Constants.whiteColor,
            )),
      ),
    );
  }
}
