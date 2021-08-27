import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_key.dart';
import '../models/news_model.dart';
import 'package:flutter/material.dart';

class NewsApi {
  static Future<List<NewsModel>> getNews() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=" + APIKey.key));

    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      List news = result['articles'];

      debugPrint(news.toString());

      return NewsModel.newsFromApi(news);
    } else {
      throw Exception('Failed to load News');
    }
  }
}
