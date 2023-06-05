import 'package:blogs_app/utils/constants.dart';
import 'package:blogs_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/blog_controller.dart';
import '../models/blog_model.dart';
import '../utils/strings_manager.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_underline_field.dart';

class AddBlogScreen extends StatefulWidget {
  static const String routeName = '/addBlogScreen';

  const AddBlogScreen({Key? key, this.isEdit = false, this.blog})
      : super(key: key);

  final bool isEdit;
  final Blog? blog;

  @override
  State<AddBlogScreen> createState() => _AddBlogScreennState();
}

class _AddBlogScreennState extends State<AddBlogScreen> {
  final blogController = Get.put(BlogController());

  @override
  void initState() {
    if (widget.isEdit) {
      blogController.blogTitleController.text =
          widget.blog!.title.capitalizeFirstOfEach;
      blogController.blogDescriptionController.text = widget.blog!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.scaffoldBgColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Constants.secondaryColor,
            ),
            onPressed: () {
              blogController.resetFields();
              Get.back();
            },
          ),
          backgroundColor: Constants.scaffoldBgColor,
          elevation: 0,
          title: Txt(
            text: widget.isEdit
                ? StringsManager.editBlogTxt
                : StringsManager.addBlogTxt,
            color: Constants.primaryColor,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Constants.secondaryColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Constants.marginL),
            child: Form(
              key: blogController.addFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: Constants.sizeSemiM,
                  ),
                  UnderlineTextFormField(
                    label: StringsManager.prodNameTxt,
                    controller: blogController.blogTitleController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ErrorManager.kBlogNameNullError;
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Txt(
                      text: StringsManager.prodImgTxt,
                      textAlign: TextAlign.start,
                      color: Constants.primaryColor,
                      fontSize: Constants.subTitleFontSize * 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: Constants.sizeM,
                  ),
                  widget.isEdit
                      ? Obx(
                          () => GestureDetector(
                            onTap: () {
                              blogController.pickImage();
                            },
                            child: blogController.posterPhoto != null
                                ? SizedBox(
                                    width: double.infinity,
                                    height: Constants.sizeXXXL,
                                    child: Image.file(
                                      blogController.posterPhoto!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    height: Constants.sizeXXXL,
                                    child: Image.network(
                                      widget.blog!.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        )
                      : Obx(
                          () {
                            return GestureDetector(
                              onTap: () => blogController.pickImage(),
                              child: blogController.posterPhoto != null
                                  ? Image.file(
                                      blogController.posterPhoto!,
                                      fit: BoxFit.fill,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: Constants.sizeXXL,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.image,
                                        color: Constants.secondaryColor,
                                      ),
                                    ),
                            );
                          },
                        ),
                  const SizedBox(
                    height: Constants.sizeS,
                  ),
                  UnderlineTextFormField(
                    label: StringsManager.descriptionTxt,
                    controller: blogController.blogDescriptionController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 300,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ErrorManager.kDescriptionNullError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: Constants.sizeL * 2,
                  ),
                  Obx(
                    () => CustomButton(
                      color: Constants.secondaryColor,
                      textColor: Constants.whiteColor,
                      text: widget.isEdit ? "Edit" : "Add",
                      buttonType: ButtonType.loading,
                      loadingWidget: blogController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Constants.scaffoldBgColor,
                              ),
                            )
                          : null,
                      onPressed: () {
                        final name =
                            blogController.blogTitleController.text.trim();
                        final description = blogController
                            .blogDescriptionController.text
                            .trim();

                        if (widget.isEdit) {
                          blogController.updateBlog(
                              widget.blog!.id,
                              name.toLowerCase(),
                              description,
                              widget.blog!.imageUrl,
                              blogController.posterPhoto,
                              blogController);
                        } else {
                          blogController.addBlog(name, description);
                        }
                      },
                      hasInfiniteWidth: true,
                    ),
                  ),
                  const SizedBox(
                    height: Constants.sizeXL,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
