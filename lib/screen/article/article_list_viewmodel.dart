import 'package:flutter/foundation.dart';
import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';

enum UiState {
  initial,
  loading,
  success,
  error,
}

class ArticleListViewModel extends ChangeNotifier {
  final ArticleRepository articleRepository;
  UiState uiState = UiState.initial;
  List<Article> articles = [];

  ArticleListViewModel({required this.articleRepository});

  Future<void> fetch() async {
    uiState = UiState.loading;
    notifyListeners();
    try {
      final list = await articleRepository.getList(DateTime.now());

      articles = list;
      uiState = UiState.success;
      notifyListeners();
    } catch (e) {
      uiState = UiState.error;
      notifyListeners();
    }
  }
}
