import 'package:flutter/foundation.dart';
import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';

enum UiState {
  initial,
  loading,
  success,
  error,
  loadingMore,
  fetchMoreError,
}

class ArticleListViewModel extends ChangeNotifier {
  final ArticleRepository articleRepository;
  UiState uiState = UiState.initial;
  List<Article> articles = [];
  bool _hasNext = false;

  ArticleListViewModel({required this.articleRepository});

  Future<void> fetch() async {
    uiState = UiState.loading;
    notifyListeners();
    try {
      final list = await articleRepository.getList(DateTime.now());

      _hasNext = list.isNotEmpty;
      articles = list;
      uiState = UiState.success;
      notifyListeners();
    } catch (e) {
      uiState = UiState.error;
      notifyListeners();
    }
  }

  Future<void> fetchMore() async {
    if (uiState == UiState.loadingMore) {
      return;
    }
    if (articles.isEmpty) {
      return;
    }
    if (!_hasNext) {
      return;
    }
    uiState = UiState.loadingMore;
    notifyListeners();
    try {
      final list = await articleRepository.getList(articles.last.date);

      if (list.isEmpty) {
        _hasNext = false;
      } else {
        _hasNext = true;
        List<Article> newArticles = [];
        newArticles.addAll(articles);
        newArticles.addAll(list);

        articles = newArticles;
      }
      uiState = UiState.success;
      notifyListeners();
    } catch (e) {
      uiState = UiState.fetchMoreError;
      notifyListeners();
    }
  }

  void notifyFetchMoreErrorConsumed() {
    uiState = UiState.success;
    notifyListeners();
  }
}
