import 'package:flutter_news_app/src/models/article.dart';

class NewsPage {
  String _status;
  int _totalResult;
  List<Article> _articles = [];


  NewsPage.fromJson(Map<String, dynamic> parsedJson){
    _status = parsedJson['status'];
    _totalResult = parsedJson['totalResults'];
    List<Article> temp = [];
    for (int i = 0; i < parsedJson['articles'].length; i++) {
      Article result = Article.fromJson(parsedJson['articles'][i]);
      temp.add(result);
    }
    _articles = temp;
  }

  String get status => _status;
  int get totalResult => _totalResult;
  List<Article> get articles => _articles;
}