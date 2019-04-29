import 'package:flutter_news_app/src/models/article.dart';
import 'package:flutter_news_app/src/models/news_page.dart';
import 'package:flutter_news_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SourceNewsBloc {
  final _repository = Repository();
  final _newsFetcherTop = PublishSubject<List<Article>>();

  int totalLength = -1;
  int page = 1;
  List <Article> articlesList = List<Article>();

  Observable<List<Article>> get news => _newsFetcherTop.stream;

  fetchNews(String source) async {
    if(totalLength == -1 || totalLength > articlesList.length){
      print('load p ' + page.toString());
      NewsPage newsPage = await _repository.fetchNewsBySource(source, page);
      articlesList.addAll(newsPage.articles);
      totalLength = newsPage.totalResult;
      page++;
      _newsFetcherTop.sink.add(articlesList);
    } else {
      print('all news loaded');
    }
  }

  bool mayLoadMore(){
    return totalLength > articlesList.length;
  }

  dispose() {
    _newsFetcherTop.close();
  }
}

final newsBloc = SourceNewsBloc();