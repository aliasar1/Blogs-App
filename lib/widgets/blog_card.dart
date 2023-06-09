import 'package:blogs_app/controllers/blog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blogs_app/models/blog_model.dart';
import 'package:blogs_app/utils/extensions.dart';

import 'package:blogs_app/views/blog_overview_screen.dart';

import '../utils/constants.dart';
import 'custom_text.dart';

class BlogCard extends StatelessWidget {
  BlogCard(
      {super.key,
      required this.blog,
      this.isHomePageRoute = false,
      this.isBookmark = false});

  final bool isHomePageRoute;
  final Blog blog;
  final bool isBookmark;

  final controller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(BlogOverviewScreen(
          blog: blog,
          isHomePageRoute: isHomePageRoute,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constants.backgroundColor,
        ),
        constraints: const BoxConstraints(
          maxHeight: 145,
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
          child: Column(
            children: [
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
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          controller.toggleFavoriteStatus(blog);
                        },
                        child: Icon(
                          isBookmark
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                          color: Constants.secondaryColor,
                          size: 30,
                        ),
                      ),
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
