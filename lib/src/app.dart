import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/ui/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage()
        }
    );
  }
}
