import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainSwiperProvider extends ChangeNotifier {
  MainSwiperProvider() {
    onInit();
  }

  PersistentTabController? bottomBarController;
  var initialPage = 0;
  var selectedItems = [];

  void onInit() {
    bottomBarController = PersistentTabController(initialIndex: initialPage);
    selectedItems.add(0);
  }

  void swithBottomNavBar(int index) {
    bottomBarController!.jumpToTab(index);
    notifyListeners();
  }

  void selectBarItem(int index) {
    if (selectedItems.isNotEmpty && (selectedItems.last != index)) {
      selectedItems.add(index);
      bottomBarController!.index = selectedItems.last;
    } else if (selectedItems.isEmpty) {
      selectedItems.add(index);
      bottomBarController!.index = selectedItems.last;
    }
  }

  void pressBack() {
    if (selectedItems.length > 1) {
      selectedItems.removeLast();
      bottomBarController!.index = selectedItems.last;
    }
    notifyListeners();
  }
}
