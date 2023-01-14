import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/components/drawer/app_drawer.dart';
// ignore: library_prefixes

import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';
import 'package:lojateamodas/src/pages/home/category/category_tile.dart';
import 'package:lojateamodas/src/pages/home/controller/home_controller.dart';
import 'package:lojateamodas/src/pages/home/item/item_tile.dart';
import 'package:lojateamodas/src/pages/widgets/app_name_widget.dart';
import 'package:lojateamodas/src/pages/widgets/shimer_custtom.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  final UtilsServices utilsServices = UtilsServices();

  final searchController = TextEditingController();

  // final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeTab = MediaQuery.of(context).size;
    return Scaffold(
      drawer: sizeTab.width > 800 ? const AppDrawer() : null,
      //appBar
      appBar: AppBar(
        leading: sizeTab.width < 800
            ? IconButton(
                onPressed: () => Get.toNamed(PagesRoutes.notification),
                icon: const Icon(
                  Icons.notifications,
                ),
                color: CustomColors.customSwatchColor,
              )
            : Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(
                        size: 35,
                        color: Colors.pink.shade800,
                        Icons.reorder,
                      ),
                    ),
                  );
                },
              ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GetBuilder<CartController>(
              builder: (controller) {
                return Row(
                  children: [
                    if (sizeTab.width > 800)
                      const SizedBox(
                        width: 20,
                      ),
                    //   if (sizeTab.width > 800)
                    IconButton(
                      onPressed: () {
                        //TODO IMPLANTAR A PESQUISA
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                      color: CustomColors.customSwatchColor,
                    ),
                    if (sizeTab.width > 800)
                      IconButton(
                        onPressed: () => Get.toNamed(PagesRoutes.notification),
                        icon: const Icon(
                          Icons.notifications,
                        ),
                        color: CustomColors.customSwatchColor,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Badge(
                      badgeColor: CustomColors.customContrastColor,
                      badgeContent: Text(
                        controller.cartItems.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () => Get.toNamed(PagesRoutes.checkout),
                        icon: const Icon(
                          Icons.add_card,
                        ),
                        color: CustomColors.customSwatchColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
        //nome do app
        title: const AppNamedWidget(),
      ),

      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1000,
          ),
          child: Column(
            children: [
              //   // Campo de pesquisa
              //   GetBuilder<HomeController>(
              //     builder: (controller) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 20,
              //           vertical: 10,
              //         ),
              //         child: sizeTab.width < 800
              //             ? TextFormField(
              //                 controller: searchController,
              //                 onChanged: (value) {
              //                   controller.searchTitle.value = value;
              //                   // print(value);
              //                 },
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.white,
              //                   isDense: true,
              //                   hintText: 'Pesquise Aqui...',
              //                   hintStyle: TextStyle(
              //                     color: Colors.pink.shade400,
              //                     fontSize: 14,
              //                   ),
              //                   prefixIcon: const Icon(
              //                     Icons.search,
              //                     color: Colors.black87,
              //                     size: 21,
              //                   ),
              //                   suffixIcon: controller
              //                           .searchTitle.value.isNotEmpty
              //                       ? IconButton(
              //                           onPressed: () {
              //                             searchController.clear();
              //                             controller.searchTitle.value = '';
//
              //                             FocusScope.of(context).unfocus();
              //                           },
              //                           icon: Icon(
              //                             Icons.close,
              //                             color: CustomColors.customContrastColor,
              //                             size: 21,
              //                           ),
              //                         )
              //                       : null,
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(60),
              //                     borderSide: const BorderSide(
              //                       width: 0,
              //                       style: BorderStyle.none,
              //                     ),
              //                   ),
              //                 ),
              //               )
              //             : null,
              //       );
              //     },
              //   ),
              //categorias
              GetBuilder<HomeController>(
                builder: (controller) {
                  return Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 40,
                    child: !controller.isProductLoading
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return CategoryTile(
                                onPressed: () {
                                  controller.selectCategory(
                                      controller.allCategories[index]);
                                },
                                category: controller.allCategories[index].title,
                                isSelected: controller.allCategories[index] ==
                                    controller.currentCategory,
                              );
                            },
                            separatorBuilder: (_, index) => const SizedBox(
                              width: 10,
                            ),
                            itemCount: controller.allCategories.length,
                          )
                        : ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              5,
                              (index) => Container(
                                margin: const EdgeInsets.only(
                                  right: 12,
                                ),
                                alignment: Alignment.center,
                                child: CustomShimmer(
                                  height: 30,
                                  width: 80,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),

              //grid
              GetBuilder<HomeController>(
                builder: (controller) {
                  return Expanded(
                    child: !controller.isProductLoading
                        ? Visibility(
                            visible: (controller.currentCategory?.items ?? [])
                                .isNotEmpty,
                            replacement: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 40,
                                  color: CustomColors.customSwatchColor,
                                ),
                                const Text(
                                  'Não há itens para apresentar',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            child: GridView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: sizeTab.width < 800 ? 2 : 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 9 / 11.5,
                              ),
                              itemCount: controller.allProducts.length,
                              itemBuilder: (_, index) {
                                if (((index + 1) ==
                                        controller.allProducts.length) &&
                                    !controller.isLatPage) {
                                  controller.loadMoreProducts();
                                }

                                return ItemTile(
                                  item: controller.allProducts[index],
                                );
                              },
                            ),
                          )
                        : GridView.count(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: sizeTab.width < 800 ? 2 : 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 9 / 11.5,
                            children: List.generate(
                              10,
                              (index) => CustomShimmer(
                                height: double.infinity,
                                width: double.infinity,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
