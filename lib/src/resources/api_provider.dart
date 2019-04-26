import 'package:flutter_news_app/src/models/news_page.dart';
import 'package:flutter_news_app/src/models/sources_container.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ApiProvider {
  Client client = Client();
  final _apiKey = "ce9d54db71b644d695bc59e3a02c01ef";
  final _baseUrl = "https://newsapi.org/v2/top-headlines?";

  String link =
      "https://newsapi.org/v2/top-headlines?country=ru&apiKey=ce9d54db71b644d695bc59e3a02c01ef";
  Future<NewsPage> fetchNews(int page) async {
    String url = 'https://newsapi.org/v2/top-headlines?' +
        'country=ru&' +
        'page='+ page.toString() + '&' +
        "apiKey=$_apiKey";
    final response = await client.get(url);
    print(response.body);
    return NewsPage.fromJson(json.decode(response.body));
  }

  Future<Sources> getSources() async {
    String url = 'https://newsapi.org/v2/sources?apiKey=ce9d54db71b644d695bc59e3a02c01ef' + '&country=ru';
    final response = await client.get(url);
    print(response.body);
    return Sources.fromJson(json.decode(response.body));
  }

}