import 'dart:io';

import 'package:blogs_app/views/myblogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/blog_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../views/blog_overview_screen.dart';

class BlogController extends GetxController {
  final RxList<Blog> _blogs = RxList<Blog>([]);
  List<Blog> get blogs => _blogs;

  final RxList<Blog> _myBlogs = RxList<Blog>([]);
  List<Blog> get myBlogs => _myBlogs;

  final RxList<Blog> _favBlogs = RxList<Blog>([]);
  List<Blog> get favBlogs => _favBlogs;

  final blogTitleController = TextEditingController();
  final blogDescriptionController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  final addFormKey = GlobalKey<FormState>();

  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get posterPhoto => _pickedImage.value;

  final Rx<String> _blogNameRx = "".obs;
  final Rx<String> _blogDescriptionRx = "".obs;

  String get blogName => _blogNameRx.value;
  String get blogDescription => _blogDescriptionRx.value;

  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
    fetchFavoriteBlogs(firebaseAuth.currentUser!.uid);
  }

  void fetchBlogs() {
    isLoading.value = true;
    firestore.collection('blogs').get().then((querySnapshot) {
      final blogs = querySnapshot.docs.map((doc) {
        final blogData = doc.data();
        final blog = Blog.fromMap(blogData);

        if (blog.authorId == firebaseAuth.currentUser!.uid) {
          _myBlogs.add(blog);
        }
        return blog;
      }).toList();

      _blogs.value = blogs;
    });
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<String> _uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child('blogs').child(id);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUniqueId() async {
    var allDocs = await firestore.collection('blogs').get();
    int len = allDocs.docs.length;
    return len.toString();
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Blog Picture Added!',
          'You have successfully added your Blog picture!');
    }
    _pickedImage.value = File(pickedImage!.path);
    update();
  }

  Future<void> addBlog(String title, String description) async {
    if (addFormKey.currentState!.validate()) {
      addFormKey.currentState!.save();
      toggleLoading();
      String id = await getUniqueId();
      // String? imageUrl;
      // if (_pickedImage.value != null) {
      //   imageUrl = await _uploadToStorage(_pickedImage.value!, id);
      // }

      title = title.toLowerCase();

      var userDetails = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      User user = User.fromSnap(userDetails);

      Blog blog = Blog(
        id: id,
        title: title,
        description: description,
        // imageUrl: imageUrl ?? "",
        authorId: firebaseAuth.currentUser!.uid,
        authorName: user.name,
        authorEmail: user.email,
      );
      await firestore.collection('blogs').doc(id).set(blog.toJson());
      toggleLoading();
      _myBlogs.add(blog);
      Get.offAll(MyBlogsScreen());
      Get.snackbar(
        'Success!',
        'Blog added successfully.',
      );
      resetFields();
    }
  }

  Future<String> _updateToStorage(File newImage, String id) async {
    Reference ref = firebaseStorage.ref().child('blogs').child(id);

    await ref.delete();

    UploadTask uploadTask = ref.putFile(newImage);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getImageFromStorage(String id) async {
    Reference ref = firebaseStorage.ref().child('blogs').child(id);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateBlog(
    String id,
    String title,
    String description,
    // String oldImageUrl,
    // File? image,
    BlogController controller,
  ) async {
    toggleLoading();
    // String imageUrl = "";
    // if (image != null) {
    //   imageUrl = await _updateToStorage(image, id);
    // } else {
    //   imageUrl = oldImageUrl;
    // }

    var userDetails = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    User user = User.fromSnap(userDetails);

    title = title.toLowerCase();
    Blog blog = Blog(
      id: id,
      title: title,
      description: description,
      // imageUrl: imageUrl,
      authorId: firebaseAuth.currentUser!.uid,
      authorName: user.name,
      authorEmail: user.email,
    );

    await firestore
        .collection('blogs')
        .doc(id)
        .update(blog.toJson())
        .whenComplete(() {
      toggleLoading();
      Get.offAll(BlogOverviewScreen(
        blog: blog,
      ));
      Get.snackbar(
        'Blog Updated.',
        'You have successfully updated your Blog.',
      );
      resetFields();
    });
  }

  Future<void> deleteBlog(String blogId) async {
    await firestore.collection('blogs').doc(blogId).delete();
    await firebaseStorage.ref().child('blogs').child(blogId).delete();
  }

  Future<void> toggleFavoriteStatus(Blog blog) async {
    try {
      var userDocRef =
          firestore.collection('bookmark').doc(firebaseAuth.currentUser!.uid);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var blogIds = userDoc.data()?['blogIds'] ?? [];

        if (blogIds.contains(blog.id)) {
          blogIds.remove(blog.id);
          Get.snackbar('Success!', 'Blog removed from bookmarks.');
        } else {
          blogIds.add(blog.id);
          Get.snackbar('Success!', 'Blog added to bookmarks.');
        }

        await userDocRef.update({'blogIds': blogIds});
      } else {
        await userDocRef.set({
          'blogIds': [blog.id]
        });
        Get.snackbar('Success!', 'Blog added to bookmarks.');
      }

      fetchFavoriteBlogs(firebaseAuth.currentUser!.uid);
    } catch (error) {
      Get.snackbar('Failure!', error.toString());
    }
  }

  Future<bool> getFavoriteStatus(String blogId) async {
    try {
      var userDocRef =
          firestore.collection('bookmark').doc(firebaseAuth.currentUser!.uid);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var favoritesData = userDoc.data();
        var blogIds = favoritesData?['blogIds'] ?? [];

        return blogIds.contains(blogId);
      } else {
        return false;
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return false;
    }
  }

  Future<List<Blog>> fetchFavoriteBlogs(String userId) async {
    try {
      var userDocRef = firestore.collection('bookmark').doc(userId);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var favoritesData = userDoc.data();
        var blogIds = favoritesData!['blogIds'] as List<dynamic>;

        var favoriteBlogs = <Blog>[];

        for (var blogId in blogIds) {
          var blogDocRef = firestore.collection('blogs').doc(blogId);
          var blogDoc = await blogDocRef.get();

          if (blogDoc.exists) {
            var blogData = blogDoc.data();
            var blog = Blog.fromMap(blogData!);
            favoriteBlogs.add(blog);
          }
        }
        isLoading.value = false;
        return favoriteBlogs;
      } else {
        isLoading.value = false;
        return [];
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failure!', error.toString());
      return [];
    }
  }

  void resetFields() {
    blogTitleController.clear();
    blogDescriptionController.clear();
    _pickedImage.value = null;
  }
}
