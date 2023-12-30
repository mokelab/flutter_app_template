import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';

class ArticleDetailViewModel extends StateNotifier<UiState> {
  final ArticleRepository articleRepository;

  ArticleDetailViewModel({required this.articleRepository}) : super(Initial());

  Future<void> fetchData(ArticleId articleId) async {
    state = Loading();
    try {
      final article = await articleRepository.getById(articleId);
      state = Success(article: article);
    } catch (e) {
      state = Error(e: e);
    }
  }
}

sealed class UiState {}

class Initial extends UiState {}

class Loading extends UiState {}

class Success extends UiState {
  final Article article;

  Success({required this.article});
}

class Error extends UiState {
  final Object e;

  Error({required this.e});
}
