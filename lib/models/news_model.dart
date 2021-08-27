class NewsModel {
  final String title;
  final String description;
  final String author;
  final String time;
  final String url;
  final String imgUrl;

  NewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imgUrl,
    required this.time,
  });

  factory NewsModel.fromJson(Map json) {
    return NewsModel(
        author: json['author'].toString(),
        title: json['title'].toString(),
        description: json['content'].toString(),
        url: json['url'].toString(),
        imgUrl: json['urlToImage'].toString(),
        time: json['publishedAt'].toString());
  }

  static List<NewsModel> newsFromApi(List data) {
    return data.map((element) => NewsModel.fromJson(element)).toList();
  }
}
