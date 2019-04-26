import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/news_page.dart';
import 'package:flutter_news_app/src/resources/api_provider.dart';
import 'package:flutter_news_app/src/resources/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {

  @override
  NewsListState createState() => new NewsListState();
}

class NewsListState extends State<NewsList> {

  List data;
  ScrollController _controller;

  String link =
      "https://newsapi.org/v2/top-headlines?country=ru&apiKey=ce9d54db71b644d695bc59e3a02c01ef";

  String curNews;

  @override
  void initState() {
    data = new List();
    this.getData(0);
    _controller = new ScrollController()..addListener(_scrollListener);
  }

  Future<String> getData(int since) async {
    var response = await http.get(
        Uri.encodeFull(link),
        headers: {
          "Accept": "application/json"
        }
    );
    this.setState(() {

      var data = json.decode(response.body);
      var rest = data["articles"] as List;
      //list = rest.map<Article>((json) => Article.fromJson(json)).toList();
      // data = json.decode(response.body);
      this.data.addAll(rest);
    });

    print(this.data.length);
    for(var l in this.data){
      print(l["description"]);
    }

  //  Future<NewsPage> news = NewsApiProvider.fetchNews();
    return "Success!";
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
            itemCount:  data.length + 1,
            controller: _controller,
            itemBuilder: (BuildContext context, int index){
              return index == data.length ?

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
                  curNews = data[index]['url'];
                  print(data[index]['url']);
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
                              child: Image.network(data[index]['urlToImage'], fit: BoxFit.cover)
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(data[index]['title'], textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),)
                            ,
                          ),
                          SizedBox(width: 8)
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(data[index]['description']!=null ? data[index]['description'] : "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 14, color: Colors.black87))
                    ],
                  ),
                ),
              );


              /*     ListTile(
            onTap: (){
              curNews = data[index]['url'];
              print(data[index]['url']);
              Navigator.pushNamed(context, '/second');
            },
            title: Text(data[index]['title']),
            subtitle: new Text(data[index]['description']!=null ? data[index]['description'] : ""),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[index]['urlToImage']),
            ),
          );*/
            })
    );
  }


  void _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print("reach the bottom");
      getData(data[data.length-1]["id"]);
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the top');
    }
  }
}