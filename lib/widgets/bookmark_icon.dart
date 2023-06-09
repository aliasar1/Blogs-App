import 'package:blogs_app/controllers/blog_controller.dart';
import 'package:blogs_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/blog_model.dart';

class BookmarkIcon extends StatefulWidget {
  final Blog blog;
  final BlogController blogController;

  BookmarkIcon({required this.blog, required this.blogController});

  @override
  _BookmarkIconState createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool isBookmarked = false;

  @override
  void initState() {
    _getFavStatus();
    super.initState();
  }

  void _getFavStatus() async {
    bool favStatus =
        await widget.blogController.getFavoriteStatus(widget.blog.id);
    setState(() {
      isBookmarked = favStatus;
    });
  }

  void _toggleFavStatus() async {
    widget.blogController.toggleFavoriteStatus(widget.blog);
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toggleFavStatus(),
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
        color: Constants.secondaryColor,
      ),
    );
  }
}
