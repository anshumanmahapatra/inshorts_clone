import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:inshorts_clone/services/news_api.dart';
import '../models/news_model.dart';

class Controller extends GetxController {
  @override
  void onInit() {
    getNewsArticles();
    pageController1.value.addListener(() {
      changeHorizontalPixel(pageController1.value.offset.floor());
      //Right Side Right Scroll
      if (horizontalIndex.value == 1 && doNotShowTop.value == false) {
        changeBoolForShowingBottom(true);
      }
      if (horizontalPixel.value > (width) * (1.25)) {
        hideTop();
        hideBottom();
      }
      //Right Side Left Scroll
      if (horizontalPixel.value > width &&
          horizontalPixel.value <= (width) * (1.25) &&
          pageController1.value.position.userScrollDirection ==
              ScrollDirection.forward &&
          boolForShowingBottom.value == true) {
        showTop();
      }
      //Left Side Left Scroll
      if (horizontalIndex.value == 0 &&
          pageController1.value.position.userScrollDirection ==
              ScrollDirection.forward) {
        showTop();
        changeOffset(pageController1.value.offset.floorToDouble());
      }
      if (leftScrollOffset.value >= 0.0 && leftScrollOffset.value <= 25.0) {
        changeLeftScrollOpacity(leftScrollOffset.value);
      }
      if (leftScrollOffset >= width - 25.0 && leftScrollOffset.value <= width) {
        changeRightScrollOpacity(leftScrollOffset.value);
      }
      if (horizontalPixel.value <= width) {
        changeOffset(pageController1.value.offset.floorToDouble());
      }
    });
    super.onInit();
  }

  double width = Get.mediaQuery.size.width;

  var heightOfBottom = 0.0.obs;
  var heightOfTop = 0.0.obs;

  var currentVerticalPageIndex = 0.obs;

  var horizontalPixel = Get.mediaQuery.size.width.obs;
  var horizontalIndex = 1.obs;
  //Left Scroll Offset is made because if we use horizontalPixel for the same
  //Then the values in Animated padding will be negative generating error
  var leftScrollOffset = 360.0.obs;
  var leftScrollOpacity = 0.0.obs;
  var rightScrollOpacity = 1.0.obs;

  var doNotShowTop = true.obs;
  var doNotShowBottom = true.obs;
  var boolForShowingBottom = false.obs;

  Rx<PageController> pageController1 = PageController().obs;
  Rx<PageController> pageController2 = PageController().obs;

  Future<List<NewsModel>>? newsArticles;

  getNewsArticles() {
    newsArticles = NewsApi.getNews();
  }

  void hideBottom() {
    doNotShowBottom.value = true;
    heightOfBottom.value = 0.0;
  }

  void showBottom() {
    doNotShowBottom.value = false;
    heightOfBottom.value = 108.0;
  }

  void hideTop() {
    doNotShowTop.value = true;
    heightOfTop.value = 0.0;
  }

  void showTop() {
    doNotShowTop.value = false;
    heightOfTop.value = 88.0;
  }

  void changeOffset(double val) {
    leftScrollOffset.value = val;
  }

  void changeLeftScrollOpacity(double val) {
    leftScrollOpacity.value = 1 - (val / 25);
  }

  void changeRightScrollOpacity(double val) {
    rightScrollOpacity.value = 1 - ((width - val) / 25);
  }

  void changeBoolForShowingBottom(bool val) {
    boolForShowingBottom.value = val;
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
