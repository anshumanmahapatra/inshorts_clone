
import 'package:get/get.dart';

class Controller extends GetxController {
  var heightOfBottom = 0.0.obs;
  var heightOfTop = 0.0.obs;

  var countOfSwitcher = 0.obs;

  var currentVerticalPageIndex = 0.obs;

  var horizontalPixel = Get.mediaQuery.size.width.obs;
  var horizontalIndex = 1.obs;

  var doNotShowTop = true.obs;
  var doNotShowBottom = true.obs;


  void hideBottom() {
    doNotShowBottom.value = true;
    heightOfBottom.value = 0.0;
    countOfSwitcher.value = 0;
  }

  void showBottom() {
    doNotShowBottom.value = false;
    heightOfBottom.value = 108.0;
    countOfSwitcher.value = 1;
  }

  void hideTop() {
    doNotShowTop.value = true;
    heightOfTop.value = 0.0;
  }

  void showTop() {
    doNotShowTop.value = false;
    heightOfTop.value = 92.0;
  }

  void changeVerticalPageIndex(int index) {
    currentVerticalPageIndex.value = index;
  }

  void changeHorizontalPixel(int position) {
    horizontalPixel.value = position.toDouble();
  }


  void changeHorizontalIndex(int index) {
    horizontalIndex.value = index;
  }

}
