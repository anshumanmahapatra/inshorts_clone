import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../screens/error.dart';
import '../screens/loading_screen.dart';
import '../screens/home.dart';
import '../models/news_model.dart';
import '../controller/controller.dart';

class PseudoHome extends StatelessWidget {
  const PseudoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: FutureBuilder<List<NewsModel>>(
            future: controller.newsArticles,
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
