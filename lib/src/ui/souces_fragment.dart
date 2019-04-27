import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/source.dart';
import 'package:flutter_news_app/src/blocs/sources_bloc.dart';
import 'package:flutter_news_app/src/ui/source_news.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SourcesListState();
  }
}

class SourcesListState extends State<SourcesList>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sourceBloc.fetchSources();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: sourceBloc.sources,
        builder: (context, AsyncSnapshot<List<Source>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget buildList(AsyncSnapshot<List<Source>> snapshot) {
    return new ListView.separated(
        separatorBuilder: (context, index) => Divider(
      color: Colors.black,
    ),
        itemCount:  snapshot.data.length,
        itemBuilder: (BuildContext context, int index){
          return
            GestureDetector(
              onTap: (){
                print(snapshot.data[index].url);
                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SourceNews(snapshot.data[index].name, snapshot.data[index].id);
                }),
              );
              },
              child:  Container(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].description, textAlign: TextAlign.justify),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          child: Text(cutHttp(snapshot.data[index].url), style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                            launch(snapshot.data[index].url);
                          }
                      ),
                    )
                  ],
                )
                ,
              ),
            );
        });
  }

  String cutHttp(String url){
    return url.substring(url.lastIndexOf('//')+2,url.length);
  }
}
