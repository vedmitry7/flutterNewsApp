import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/article.dart';
import 'package:flutter_news_app/src/models/news_page.dart';
import 'package:flutter_news_app/src/resources/api_provider.dart';
import 'package:flutter_news_app/src/resources/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList2 extends StatefulWidget {

  @override
  NewsList2State createState() => new NewsList2State();
}

class NewsList2State extends State<NewsList2> {

  ScrollController _controller;
  List<Article> articles;
  int totalCount;
  int page = 1;
  ApiProvider provider = ApiProvider();
  String curNews;

  @override
  void initState() {
    articles = new List();
    getNextPage();
    _controller = new ScrollController()..addListener(_scrollListener);
  }

  Future<NewsPage> getNextPage() {
    print('p ' + page.toString());
    Future<NewsPage> newsPage = provider.fetchNews(page);
    newsPage.then((value){
      setState(() {
        page++;
        totalCount = value.totalResult;
        articles.addAll(value.articles);
      });
      print('count - ' + value.totalResult.toString());
      value.articles.forEach((a){
        print(" - " + a.title);
      });
    });
    return newsPage;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              ListTile(
                leading: new Icon(Icons.rss_feed),
                title: Text('Source'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.flag),
                title: Text('Countries'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.category),
                title: Text('Categories'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        appBar: new AppBar(
          title: new Text("Breacking News"),
          backgroundColor: Colors.black87,),
        body: new ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount:  articles.length + 1,
            controller: _controller,
            itemBuilder: (BuildContext context, int index){
              return index == articles.length ?

              Container(
                height: 56,
                width: 56,
                child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(Colors.blue),
                    strokeWidth: 3.0),
              )
                  :
              GestureDetector(
                onTap: (){
                  curNews = articles[index].url;
                  print(articles[index].url);
                  Navigator.pushNamed(context, '/second');
                },
                child:  Container(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                              width: 78,
                              height: 78,
                              child: articles[index].urlToImage!=null ?
                              Image.network(articles[index].urlToImage, fit: BoxFit.cover)
                                  :
                                  Icon(Icons.broken_image)
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(articles[index].title, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),)
                            ,
                          ),
                          SizedBox(width: 8)
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(articles[index].description!=null ? articles[index].description : "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 14, color: Colors.black87))
                    ],
                  ),
                ),
              );
            })
    );
  }


  void _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print("reach the bottom");


      if(totalCount>articles.length)
      getNextPage();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the top');
    }
  }
}