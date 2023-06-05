import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/blog_model.dart';
import '../utils/constants.dart';

class SearchController extends GetxController {
  final Rx<List<Blog>> _searchedBlogs = Rx<List<Blog>>([]);

  List<Blog> get searchedBlogs => _searchedBlogs.value;

  Future<void> searchBlog(String typedUser) async {
    if (typedUser.isEmpty) {
      _searchedBlogs.value = [];
      return;
    }
    List<Blog> retVal = [];
    QuerySnapshot query = await firestore
        .collection('blogs')
        .where('title', isGreaterThanOrEqualTo: typedUser.toLowerCase())
        .get();
    if (query.docs.isNotEmpty) {
      for (var elem in query.docs) {
        Blog blog = Blog.fromSnap(elem);
        if (blog.title.toLowerCase().contains(typedUser.toLowerCase())) {
          retVal.add(blog);
        }
      }
    }
    _searchedBlogs.value = retVal;
  }
}
