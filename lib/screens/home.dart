import 'package:flutter/material.dart';
import 'package:inshorts_clone/models/news_model.dart';
import 'package:inshorts_clone/screens/discover.dart';
import 'package:inshorts_clone/screens/news_web_view.dart';
import 'package:inshorts_clone/widgets/news_widget.dart';

class Home extends StatefulWidget {
  final List<NewsModel> newsList;
  const Home({Key? key, required this.newsList}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? currentIndex;

  @override
  void initState() { 
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(initialPage: 1),
      scrollDirection: Axis.horizontal,
      children: [
        const Discover(),
        PageView.builder(
            // controller: pageController,
            key: const PageStorageKey<String>('page-two'),
            scrollDirection: Axis.vertical,
            itemCount: widget.newsList.length,
            itemBuilder: (context, index) {
              // if (index == currentPage!.floor()) {
              //   return Transform(
              //       transform: Matrix4.identity()
              //         ..setEntry(3, 2, -0.001)
              //         ..rotateX(currentPage! - index),
              //       child: Sample().sampleWidget(context, test[index]));
              // } else if (index == currentPage!.floor() + 1) {
              //   return Transform(
              //       transform: Matrix4.identity()
              //         ..setEntry(3, 2, -0.001)
              //         ..rotateX(currentPage! - index),
              //       child: Sample().sampleWidget(context, test[index]));
              // } else {
              return NewsWidget().showNews(context, widget.newsList[index]);
              // }
            },
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            }),
        NewWebView(newsModel: widget.newsList[currentIndex!]),
      ],
    );
  }
}
