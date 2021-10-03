import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../controller/controller.dart';
import '../models/news_model.dart';
import '../screens/discover.dart';
import '../screens/news_web_view.dart';
import '../widgets/news_widget.dart';

class Home extends StatelessWidget {
  final List<NewsModel> newsList;

  const Home({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    Size size = Get.mediaQuery.size;
    double width = size.width;
    double height = size.height;
    return Obx(() {
      return Stack(
        children: [
          Container(
              width: width,
              height: height,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  )
                ],
              )),
          //Page View for Horizontal Scrolling
          PageView(
            controller: controller.pageController1.value,
            onPageChanged: (index) {
              controller.changeHorizontalIndex(index);
            },
            children: [
              //1st Page
              const Discover(),
              //Second Page with vertical scrolling
              PageView.builder(
                  key: const PageStorageKey<String>('page-two'),
                  controller: controller.pageController2.value,
                  scrollDirection: Axis.vertical,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return NewsWidget(
                      newsModel: newsList[index],
                    );
                    // }
                  },
                  onPageChanged: (index) {
                    controller.changeVerticalPageIndex(index);
                    if (controller.doNotShowTop.value == false) {
                      controller.hideTop();
                    }
                    if (controller.doNotShowBottom.value == false) {
                      controller.hideBottom();
                    }
                  }),
              //Third Page
              NewWebView(
                newsModel: newsList[controller.currentVerticalPageIndex.value],
                pageController: controller.pageController1.value,
              ),
            ],
          ),
          //Another Stack Item which serves as the common Top between 1st and 2nd page
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.decelerate,
            bottom: height - controller.heightOfTop.value,
            child: Offstage(
              offstage: controller.doNotShowTop.value,
              child: Container(
                  height: 50,
                  width: width,
                  color: Colors.white,
                  //The Top stack item having other stack items
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            AnimatedPadding(
                              padding: EdgeInsets.only(
                                  left: width / 3 -
                                      controller.leftScrollOffset.value / 3 +
                                      (controller.leftScrollOffset.value >= 0 &&
                                              controller
                                                      .leftScrollOffset.value <=
                                                  5
                                          ? 5 -
                                              controller.leftScrollOffset.value
                                          : 0)),
                              duration: const Duration(milliseconds: 1),
                            ),
                            Text("Discover",
                                style: TextStyle(
                                    fontWeight:
                                        controller.leftScrollOffset.value == 0.0
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                            const SizedBox(width: 65),
                            Text("Top News",
                                style: TextStyle(
                                    fontWeight:
                                        controller.leftScrollOffset.value ==
                                                360.0
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                            AnimatedPadding(
                              padding: EdgeInsets.only(
                                  right: controller.leftScrollOffset.value / 3),
                              duration: const Duration(milliseconds: 1),
                            ),
                          ],
                        ),
                      ),
                      //This is the bottom blue bar in the Top Stack Item
                      Positioned(
                        bottom: 5,
                        left: (width / 2) - 15,
                        child: Container(
                            width: 30,
                            height: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.blue)),
                      ),
                      //Got to Top Icon
                      AnimatedPositioned(
                        left: controller.leftScrollOffset.value >= width - 25 &&
                                controller.leftScrollOffset.value <= width
                            ? (2 * width) -
                                30 -
                                controller.leftScrollOffset.value
                            : width,
                        duration: const Duration(milliseconds: 1),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_upward_outlined,
                              color: kPrimaryColor),
                          onPressed: () {
                            controller.pageController2.value.animateToPage(0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.decelerate);
                          },
                        ),
                      ),
                      //Sliding left Settings Icons in the 1st Page
                      AnimatedPositioned(
                          top: 15,
                          right: controller.leftScrollOffset.value >= 0 &&
                                  controller.leftScrollOffset.value <= 25.0
                              ? width - (30 - controller.leftScrollOffset.value)
                              : width,
                          duration: const Duration(milliseconds: 1),
                          child: const Icon(Icons.settings_sharp,
                              color: Colors.blue)),
                      //Fading right arrow icon in 1st page
                      Positioned(
                          top: 10,
                          left: width - 28,
                          child: AnimatedOpacity(
                              opacity: controller.horizontalPixel.value > 25.0
                                  ? 0
                                  : controller.leftScrollOpacity.value,
                              duration: const Duration(milliseconds: 1),
                              child: const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.blue,
                                  size: 32))),
                      //Fading left arrow icon in 2nd page
                      Positioned(
                        right: width - 28,
                        child: AnimatedOpacity(
                            opacity:
                                controller.horizontalPixel.value < width - 28
                                    ? 0
                                    : controller.rightScrollOpacity.value,
                            duration: const Duration(milliseconds: 1),
                            child: IconButton(
                                icon: const Icon(
                                    Icons.keyboard_arrow_left_sharp,
                                    color: Colors.blue,
                                    size: 32),
                                onPressed: () {
                                  // controller.pageController1.value
                                  //     .animateToPage(0,
                                  //         duration:
                                  //             const Duration(milliseconds: 200),
                                  //         curve: Curves.linear);
                                })),
                      )
                    ],
                  )),
            ),
          )
          // AnimatedPositioned(
          //   bottom: size.height - controller.heightOfTop.value,
          //   curve: Curves.decelerate,
          //   duration: const Duration(milliseconds: 200),
          //   child: Offstage(
          //     offstage: controller.doNotShowTop.value,
          //     child: Container(
          //         height: 53,
          //         width: size.width,
          //         color: Colors.white,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             IconButton(
          //               icon: const Icon(Icons.arrow_upward_outlined,
          //                   color: kPrimaryColor),
          //               onPressed: () {
          //                 controller.pageController2.value.animateToPage(0,
          //                     duration: const Duration(milliseconds: 200),
          //                     curve: Curves.decelerate);
          //               },
          //             ),
          //           ],
          //         )),
          //   ),
          // ),
        ],
      );
    });
  }
}
