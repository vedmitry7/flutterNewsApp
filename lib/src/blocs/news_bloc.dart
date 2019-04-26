import 'package:flutter_news_app/src/models/article.dart';
import 'package:flutter_news_app/src/models/news_page.dart';
import 'package:flutter_news_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = PublishSubject<List<Article>>();

  int totalLength = -1;
  int page = 1;
  List <Article> articlesList = List<Article>();

  Observable<List<Article>> get news => _newsFetcher.stream;

  fetchNews() async {
    if(totalLength == -1 || totalLength > articlesList.length){
      print('load p ' + page.toString());
      NewsPage newsPage = await _repository.fetchAllNews(page);
      articlesList.addAll(newsPage.articles);
      totalLength = newsPage.totalResult;
      page++;
      _newsFetcher.sink.add(articlesList);
    } else {
      print('all news loaded');
    }
  }

  bool mayLoadMore(){
    return totalLength > articlesList.length;
  }

  dispose() {
    _newsFetcher.close();
  }
}

final newsBloc = NewsBloc();