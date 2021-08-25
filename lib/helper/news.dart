import 'dart:convert';
import 'package:insidescoop/section/article_section.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleSection> news = [];
  Future<void> getNews() async {
    String url =
        ("https://newsapi.org/v2/top-headlines?country=in&apiKey=cb8e868e09a1487b9655b94f2368a15a");
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleSection articleSection = ArticleSection(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"]);
          news.add(articleSection);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleSection> news = [];
  Future<void> getNews(String category) async {
    String url =
        ("https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=cb8e868e09a1487b9655b94f2368a15a");
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=cb8e868e09a1487b9655b94f2368a15a"));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleSection articleSection = ArticleSection(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              publishedAt: element["publishedAt"],
              urlToImage: element["urlToImage"],
              content: element["content"]);
          news.add(articleSection);
        }
      });
    }
  }
}
