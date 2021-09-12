import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/color_constants.dart';
import '../controller/controller.dart';
import '../models/news_model.dart';

class NewsWidget extends StatefulWidget {
  final NewsModel newsModel;
  const NewsWidget({Key? key, required this.newsModel}) : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  String? timePosted;

  int findIndex() {
    String str = "[";
    if (widget.newsModel.content.contains(str)) {
      return widget.newsModel.content.indexOf(str);
    } else {
      return widget.newsModel.content.length;
    }
  }

  String smallerOrGreater(int val) {
    if (val == 1) {
      if (widget.newsModel.content.substring(0, findIndex()).length >=
          widget.newsModel.description.length) {
        return widget.newsModel.content.substring(0, findIndex());
      } else {
        return widget.newsModel.description;
      }
    } else {
      if (widget.newsModel.content.substring(0, findIndex()).length <=
          widget.newsModel.description.length) {
        return widget.newsModel.content.substring(0, findIndex());
      } else {
        return widget.newsModel.description;
      }
    }
  }

  String showTimeAgo(String time) {
    DateTime parsedDate = DateTime.parse(time);
    DateTime now = DateTime.now();
    Duration difference = now.difference(parsedDate);
    timePosted = timeago.format(now.subtract(difference));
    return timePosted!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<Controller>(
        init: Controller(),
        builder: (controller) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                        widget.newsModel.imgUrl,
                        height: 250,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.doNotShowTop.value == false &&
                            controller.doNotShowBottom.value == false) {
                          controller.hideTop();
                          controller.hideBottom();
                        } else if (controller.doNotShowTop.value == true &&
                            controller.doNotShowBottom.value == true) {
                          controller.showTop();
                          controller.showBottom();
                        } else if (controller.doNotShowTop.value == false &&
                            controller.doNotShowBottom.value == true) {
                          controller.showBottom();
                        } else {}
                      },
                      child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: size.height - 288.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  color: Colors.white,
                                  width: size.width,
                                  padding: const EdgeInsets.only(
                                      top: 13, left: 20, right: 30),
                                  child: Text(widget.newsModel.title,
                                      style: const TextStyle(
                                          height: 1.35,
                                          fontSize: 18,
                                          fontFamily: "FF Clan OT Bold",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400))),
                              Container(
                                color: Colors.white,
                                width: size.width,
                                padding: const EdgeInsets.only(
                                    top: 7, left: 20, right: 30),
                                child: Text(smallerOrGreater(1),
                                    style: TextStyle(
                                        height: 1.7,
                                        color: Colors.grey.shade800)),
                              ),
                              Container(
                                width: size.width,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 30),
                                child: AnimatedCrossFade(
                                  crossFadeState:
                                      controller.doNotShowBottom.value == true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                  firstChild: Text(
                                      "swipe left for more at ${widget.newsModel.sourceName['name']} / ${showTimeAgo(widget.newsModel.time)}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: "FF Clan OT Bold",
                                        color: Colors.black26,
                                      )),
                                  secondChild: Text(
                                      "short by ${widget.newsModel.author}",
                                      key: ValueKey<int>(
                                          controller.countOfSwitcher.value),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: "FF Clan OT Bold",
                                        color: Colors.black26,
                                      )),
                                  duration: const Duration(milliseconds: 200),
                                ),
                              ),
                              Expanded(
                                child: Container(color: Colors.white),
                              ),
                              Container(
                                  height: 70,
                                  width: size.width,
                                  padding: const EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                  ),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black87,
                                            Colors.black54,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        smallerOrGreater(0),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Tap to read more",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 11),
                                      )
                                    ],
                                  )),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                top: size.height - controller.heightOfBottom.value,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 200),
                child: Offstage(
                  offstage: controller.doNotShowBottom.value,
                  child: Container(
                    height: 69,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.help_outline_outlined,
                                color: kPrimaryColor,
                              ),
                              SizedBox(height: 5),
                              Text("Relevancy",
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.black54))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.share_outlined,
                                color: kPrimaryColor,
                              ),
                              SizedBox(height: 5),
                              Text("Share",
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.black54))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.bookmark_outline,
                                color: kPrimaryColor,
                              ),
                              SizedBox(height: 5),
                              Text("Bookmark",
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.black54))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
