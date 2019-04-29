
import 'package:flutter_news_app/src/models/news_page.dart';
import 'package:flutter_news_app/src/models/sources_container.dart';
import 'package:flutter_news_app/src/resources/api_provider.dart';

class Repository {
  final newsApiProvider = ApiProvider();

  Future<NewsPage> fetchTopNews(v) => newsApiProvider.fetchNews(v);
  Future<NewsPage> fetchNewsBySource(s, p) => newsApiProvider.fetchNewsBySource(s, p);
  Future<Sources> getSources() => newsApiProvider.getSources();

}