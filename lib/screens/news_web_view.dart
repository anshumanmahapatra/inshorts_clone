import 'package:flutter/material.dart';
import '../models/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewWebView extends StatelessWidget {
  final NewsModel newsModel;
  const NewWebView({Key? key, required this.newsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = "com";
    int index = newsModel.url.indexOf(str);
    return Scaffold(
        appBar: AppBar(
          title: Text(newsModel.url.substring(8,index + 3)),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: newsModel.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
