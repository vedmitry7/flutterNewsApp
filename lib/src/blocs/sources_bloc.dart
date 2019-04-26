import 'package:flutter_news_app/src/models/article.dart';
import 'package:flutter_news_app/src/models/sources_container.dart';
import 'package:flutter_news_app/src/resources/repository.dart';
import 'package:flutter_news_app/src/models/source.dart';
import 'package:rxdart/rxdart.dart';

class SourcesBloc {
  final _repository = Repository();
  final _sourceFetcher = PublishSubject<List<Source>>();

  List <Source> sourcesList = List<Source>();

  Observable<List<Source>> get sources => _sourceFetcher.stream;

  fetchSources() async {
    Sources sources = await _repository.getSources();

    sourcesList.addAll(sources.sources);
    _sourceFetcher.sink.add(sourcesList);
  }

  dispose() {
    _sourceFetcher.close();
  }
}

final sourceBloc = SourcesBloc();