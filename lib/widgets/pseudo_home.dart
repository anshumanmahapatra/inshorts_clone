import 'package:flutter/material.dart';
import '../screens/error.dart';
import '../screens/loading_screen.dart';
import '../screens/home.dart';
import '../models/news_model.dart';
import '../services/news_api.dart';

class PseudoHome extends StatefulWidget {
  const PseudoHome({Key? key}) : super(key: key);

  @override
  _PseudoHomeState createState() => _PseudoHomeState();
}

class _PseudoHomeState extends State<PseudoHome> {
  late Future<List<NewsModel>> newsArticles;

  // double? currentPage = 0.0;
  // PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    newsArticles = NewsApi.getNews();
    // pageController.addListener(() {
    //   setState(() {
    //     currentPage = pageController.page;
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   pageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: FutureBuilder<List<NewsModel>>(
            future: newsArticles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Home(newsList: snapshot.data!);
              } else if (snapshot.hasError) {
                return ErrorPage(message: snapshot.error.toString());
              } else {
                return const LoadingScreen();
              }
            }),
      ),
    );
  }
}
