import 'package:blogs_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/blog_controller.dart';
import '../controllers/search_controller.dart' as ctrl;
import '../utils/constants.dart';
import '../utils/strings_manager.dart';
import '../widgets/blog_card.dart';
import '../widgets/custom_search.dart';
import '../widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    text: StringsManager.allBlogsTxt,
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
                            return BlogCard(blog: blog);
                          },
                        ),
                      );
                    } else if (blogController.blogs.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Txt(
                            text: "No blogs are available.",
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
                          itemCount: blogController.blogs.length,
                          itemBuilder: (ctx, i) {
                            final blog = blogController.blogs[i];
                            return BlogCard(
                              blog: blog,
                              isHomePageRoute: true,
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
      ),
    );
  }
}
