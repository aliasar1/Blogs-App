import 'package:blogs_app/controllers/blog_controller.dart';
import 'package:blogs_app/models/blog_model.dart';
import 'package:blogs_app/utils/extensions.dart';
import 'package:blogs_app/views/add_blog_screen.dart';
import 'package:blogs_app/views/blog_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart' as ctrl;
import '../controllers/auth_controller.dart';
import '../utils/constants.dart';
import '../utils/strings_manager.dart';
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
                          },
                        ),
                      );
                    } else if (blogController.blogs.isEmpty) {
                      return const Column(
                        children: [
                          SizedBox(height: Constants.sizeXL * 3),
                          // NoProductTemplate(),
                        ],
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: blogController.blogs.length,
                          itemBuilder: (ctx, i) {
                            final blog = blogController.blogs[i];
                            return BlogCard(blog: blog);
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

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(BlogOverviewScreen(
          blog: blog,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constants.backgroundColor,
        ),
        constraints: const BoxConstraints(
          maxHeight: 130,
          minHeight: 20,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: Constants.marginXS,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Constants.marginXS,
            horizontal: Constants.marginXS,
          ),
          child: Row(
            children: [
              // SizedBox(
              //   width: 140,
              //   height: 150,
              //   child: blog.imageUrl == ""
              //       ? const Center(
              //           child: Icon(
              //             Icons.sticky_note_2,
              //             color: Constants.secondaryColor,
              //             size: 60,
              //           ),
              //         )
              //       : Image.network(
              //           blog.imageUrl,
              //           loadingBuilder:
              //               (BuildContext context,
              //                   Widget child,
              //                   ImageChunkEvent?
              //                       loadingProgress) {
              //             if (loadingProgress == null) {
              //               return child;
              //             }
              //             return Center(
              //               child:
              //                   CircularProgressIndicator(
              //                 color:
              //                     Constants.secondaryColor,
              //                 value: loadingProgress
              //                             .expectedTotalBytes !=
              //                         null
              //                     ? loadingProgress
              //                             .cumulativeBytesLoaded /
              //                         loadingProgress
              //                             .expectedTotalBytes!
              //                     : null,
              //               ),
              //             );
              //           },
              //           errorBuilder: (BuildContext context,
              //               Object exception,
              //               StackTrace? stackTrace) {
              //             return const Icon(Icons.error);
              //           },
              //         ),
              // ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      text: blog.title.capitalizeFirstOfEach,
                      textAlign: TextAlign.start,
                      useOverflow: true,
                      fontWeight: Constants.bold,
                      fontSize: Constants.titleFontSize,
                      color: Constants.primaryColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Txt(
                      text: blog.description.capitalizeFirstOfEach,
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      useOverflow: true,
                      fontWeight: Constants.regular,
                      fontSize: Constants.subTitleFontSize,
                      color: Constants.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
