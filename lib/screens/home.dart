import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../controller/controller.dart';
import '../models/news_model.dart';
import '../screens/discover.dart';
import '../screens/news_web_view.dart';
import '../widgets/news_widget.dart';

class Home extends StatefulWidget {
  final List<NewsModel> newsList;

  const Home({Key? key, required this.newsList}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Controller controller = Get.put(Controller());
  final PageController pageController1 = PageController(initialPage: 1);
  final PageController pageController2 = PageController();
  double width = Get.mediaQuery.size.width;

  @override
  void initState() {
    super.initState();
    pageController1.addListener(() {
      controller.changeHorizontalPixel(pageController1.offset.floor());
      if (controller.horizontalPixel.value >
          (width) * (1.5)) {
        controller.hideTop();
        controller.hideBottom();
      }
      if (controller.horizontalPixel.value > width &&
          controller.horizontalPixel.value <= (width)*(1.5) &&
          pageController1.position.userScrollDirection ==
              ScrollDirection.forward) {
        controller.showTop();
      }
      if (controller.horizontalIndex.value == 0) {
        controller.showTop();
      }
    });
  }

  @override
  void dispose() {
    pageController1.dispose();
    pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<Controller>(
        init: controller,
        builder: (myController) {
          return Stack(
            children: [
              Container(
                  width: size.width,
                  height: size.height,
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
              PageView(
                controller: pageController1,
                onPageChanged: (index) {
                  myController.changeHorizontalIndex(index);
                },
                children: [
                  const Discover(),
                  PageView.builder(
                      key: const PageStorageKey<String>('page-two'),
                      controller: pageController2,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.newsList.length,
                      itemBuilder: (context, index) {
                        return NewsWidget(
                          newsModel: widget.newsList[index],
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
                  NewWebView(
                    newsModel: widget
                        .newsList[controller.currentVerticalPageIndex.value],
                    pageController: pageController1,
                  ),
                ],
              ),
              AnimatedPositioned(
                bottom: size.height - controller.heightOfTop.value,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 200),
                child: Offstage(
                  offstage: controller.doNotShowTop.value,
                  child: Container(
                      height: 53,
                      width: size.width,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_upward_outlined,
                                color: kPrimaryColor),
                            onPressed: () {
                              pageController2.animateToPage(0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.decelerate);
                            },
                          ),
                        ],
                      )),
                ),
              ),
            ],
          );
        });
  }
}
