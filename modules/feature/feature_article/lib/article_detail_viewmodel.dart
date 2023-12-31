import 'package:core_data_api/article_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_model/article.dart';

class ArticleDetailViewModel extends StateNotifier<UiState> {
  final ArticleRepository articleRepository;

  ArticleDetailViewModel({required this.articleRepository})
      : super(const Initial());

  Future<void> fetchData(ArticleId articleId) async {
    state = const Loading();
    try {
      final article = await articleRepository.getById(articleId);
      state = Success(article: article);
    } catch (e) {
      state = Error(e: e);
    }
  }
}

sealed class UiState {
  const UiState();
}

class Initial extends UiState {
  const Initial() : super();
}

class Loading extends UiState {
  const Loading() : super();
}

class Success extends UiState {
  final Article article;

  const Success({required this.article});
}

class Error extends UiState {
  final Object e;

  const Error({required this.e});
}
