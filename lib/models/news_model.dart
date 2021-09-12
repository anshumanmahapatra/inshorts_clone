class NewsModel {
  final String title;
  final String content;
  final String description;
  final Map sourceName;
  final String author;
  final String time;
  final String url;
  final String imgUrl;

  NewsModel({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.content,
    required this.description,
    required this.url,
    required this.imgUrl,
    required this.time,
  });

  factory NewsModel.fromJson(Map json) {
    return NewsModel(
        sourceName: json['source'] ?? "NA",
        author: json['author'] ?? "NA",
        title: json['title'] ?? "Title Not Available",
        content: json['content'] ?? "Description Not Available[",
        description: json['description'] ?? "Description Not Available",
        url: json['url'].toString(),
        imgUrl: json['urlToImage'] ??
            "https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png",
        time: json['publishedAt'].toString());
  }

  static List<NewsModel> newsFromApi(List data) {
    return data.map((element) => NewsModel.fromJson(element)).toList();
  }
}
