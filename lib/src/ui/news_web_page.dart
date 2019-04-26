import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {

  String url;


  NewsPage(this.url);

  @override
  NewsPageState createState() => new NewsPageState(url);
}

class NewsPageState extends State<NewsPage> {

  String url;
  num pos = 1;

  NewsPageState(this.url);

  void _loadFinished(String val){
    setState(() {
      pos = 0;
      print('finished ' + pos.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('return'),
        backgroundColor: Colors.black87,
      ),
      body: IndexedStack(
        index: pos,
        children: <Widget>[
          new WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: _loadFinished,
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      )
    );
  }



  /* num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('return'),
        backgroundColor: Colors.black87,
      ),
      body: IndexedStack(
      index: _stackToView,
      children: [
        Column(
          children: < Widget > [
            Expanded(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: url,
                  onPageFinished: _handleLoad,
                )
            ),
          ],
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    )
    );*/
}