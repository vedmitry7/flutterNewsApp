import 'package:flutter_news_app/src/models/source.dart';

class Sources {

  String _status;
  List<Source> _sources = [];

  Sources.fromJson(Map<String, dynamic> parsedJson){
    _status = parsedJson['status'];
    List<Source> temp = [];
    for (int i = 0; i < parsedJson['sources'].length; i++) {
      Source source = Source.fromJson(parsedJson['sources'][i]);
      temp.add(source);
    }
    _sources = temp;
  }

  List<Source> get sources => _sources;

}