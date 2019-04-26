import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/app.dart';

void main() => runApp(App());

/*
List<Article> list;
Future<List<Article>> _getArticles() async {
  String link =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=ce9d54db71b644d695bc59e3a02c01ef";
  var res = await http
      .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
  print(res.body);
  setState(() {
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
  });
  print("List Size: ${list.length}");
  return list;*/
