import 'package:flutter/material.dart';
import '../models/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewWebView extends StatelessWidget {
  final NewsModel newsModel;
  final PageController pageController;
  const NewWebView(
      {Key? key, required this.newsModel, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = "com";
    int index = newsModel.url.indexOf(str);
    return Scaffold(
        appBar: AppBar(
          title: Text(newsModel.url.substring(8, index + 3),
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white70,
              )),
          elevation: 0.0,
          centerTitle: true,
          toolbarHeight: 30,
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                size: 17,
              ),
              onPressed: () {
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              }),
        ),
        body: WebView(
          initialUrl: newsModel.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
