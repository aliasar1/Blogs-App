import 'package:blogs_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/search_controller.dart' as ctrl;
import '../utils/constants.dart';
import '../utils/strings_manager.dart';
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
                // Obx(
                //   () {
                //     if (.isLoading.value) {
                //       return const Expanded(
                //         child: Center(
                //           child: CircularProgressIndicator(
                //             color: ColorsManager.secondaryColor,
                //           ),
                //         ),
                //       );
                //     } else if (searchController.searchedProducts.isNotEmpty) {
                //       return Expanded(
                //         child: GridView.builder(
                //           padding: const EdgeInsets.all(10.0),
                //           itemCount: searchController.searchedProducts.length,
                //           itemBuilder: (ctx, i) {
                //             final prod = searchController.searchedProducts[i];
                //             return ProductsCard(
                //               prod: prod,
                //               controller: productController,
                //               isUserBuyer: isUserBuyer,
                //             );
                //           },
                //           gridDelegate:
                //               const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2,
                //             crossAxisSpacing: 10,
                //             mainAxisSpacing: 10,
                //           ),
                //         ),
                //       );
                //     } else if (productController.products.isEmpty) {
                //       return const Column(
                //         children: [
                //           SizedBox(height: SizeManager.sizeXL * 3),
                //           NoProductTemplate(),
                //         ],
                //       );
                //     } else {
                //       return Expanded(
                //         child: GridView.builder(
                //           padding: const EdgeInsets.all(10.0),
                //           itemCount: productController.products.length,
                //           itemBuilder: (ctx, i) {
                //             final prod = productController.products[i];
                //             return ProductsCard(
                //               prod: prod,
                //               controller: productController,
                //               isUserBuyer: isUserBuyer,
                //             );
                //           },
                //           gridDelegate:
                //               const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2,
                //             crossAxisSpacing: 10,
                //             mainAxisSpacing: 10,
                //           ),
                //         ),
                //       );
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
