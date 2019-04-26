import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/blocs/news_bloc.dart';
import 'package:flutter_news_app/src/models/article.dart';
import 'package:flutter_news_app/src/ui/news_web_page.dart';

class NewsList3 extends StatefulWidget {

  @override
  NewsList3State createState() => new NewsList3State();
}

class NewsList3State extends State<NewsList3> {

  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    newsBloc.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
            stream: newsBloc.news,
            builder: (context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            });
  }


  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print("reach the bottom");
      newsBloc.fetchNews();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the top');
    }
  }


  Widget buildList(AsyncSnapshot<List<Article>> snapshot) {
    return new ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount:  snapshot.data.length + 1,
        controller: _controller,
        itemBuilder: (BuildContext context, int index){
          return index == snapshot.data.length ?
              newsBloc.mayLoadMore() ?
          Container(
            height: 56,
            child: Padding (padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
            child: new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation(Colors.blue),
                strokeWidth: 3.0))
            ,
          ) : SizedBox(height: 0,)
              :
          GestureDetector(
            onTap: (){
              print(snapshot.data[index].url);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NewsPage(snapshot.data[index].url);
                }),
              );
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
                          child: snapshot.data[index].urlToImage!=null ?
                          Image.network(snapshot.data[index].urlToImage, fit: BoxFit.cover)
                              :
                          Icon(Icons.broken_image)
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(snapshot.data[index].title, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),)
                        ,
                      ),
                      SizedBox(width: 8)
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(snapshot.data[index].description!=null
                      ? snapshot.data[index].description : "",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14, color: Colors.black87))
                ],
              ),
            ),
          );
        });
  }
}
