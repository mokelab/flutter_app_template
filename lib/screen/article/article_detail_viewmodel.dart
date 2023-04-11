import 'package:flutter/foundation.dart';
import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';

enum UiState {
  initial,
  loading,
  success,
  error,
}

class ArticleDetailViewModel extends ChangeNotifier {
  final ArticleRepository articleRepository;
  UiState uiState = UiState.initial;
  Article? article;

  ArticleDetailViewModel({required this.articleRepository});

  Future<void> fetchData(ArticleId articleId) async {
    uiState = UiState.loading;
    notifyListeners();
    try {
      article = await articleRepository.getById(articleId);
      uiState = UiState.success;
      notifyListeners();
    } catch (e) {
      uiState = UiState.error;
      notifyListeners();
    }
  }
}
