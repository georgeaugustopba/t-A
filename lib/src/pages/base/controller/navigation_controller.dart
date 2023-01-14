import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currrentIndex;

  @override
  void onInit() {
    super.onInit();

    initNavigation(
      pageController: PageController(
        initialPage: NavigationTabs.home,
      ),
      currentIndex: NavigationTabs.home,
    );
  }

  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currrentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currrentIndex.value == page) return;

    _pageController.jumpToPage(page);
    _currrentIndex.value = page;
  }
}
