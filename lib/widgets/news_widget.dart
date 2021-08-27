import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inshorts_clone/models/news_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsWidget {
  showNews(BuildContext context, NewsModel newsModel) {
    Size size = MediaQuery.of(context).size;
    String? timePosted;

    String showTimeAgo(String time) {
      DateTime parsedDate = DateTime.parse(time);
      DateTime now = DateTime.now();
      Duration difference = now.difference(parsedDate);
      timePosted = timeago.format(now.subtract(difference));
      return timePosted!;
    }

    String str = "[";
    int index = newsModel.description.indexOf(str);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              newsModel.imgUrl,
              height: 250,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 12, left: 20, right: 30),
              child: Text(newsModel.title,
                  style: const TextStyle(
                      height: 1.4,
                      fontSize: 18,
                      fontFamily: "FF Clan OT Bold",
                      color: Colors.black,
                      fontWeight: FontWeight.w400))),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 30),
            child: Text(newsModel.description.substring(0, index),
                style: TextStyle(height: 1.65, color: Colors.grey.shade800)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10, left: 20, right: 30),
            child: Text(
                "swipe left for more at ${newsModel.author} / ${showTimeAgo(newsModel.time)}",
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: "FF Clan OT Bold",
                  color: Colors.black26,
                )),
          ),
          const Spacer(),
          Container(
              height: 70,
              width: size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 15,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.black54,
                    // Colors.black,
                    // Colors.black54
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Column(
                children: const [
                  Text(
                    "Tap to know more",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
