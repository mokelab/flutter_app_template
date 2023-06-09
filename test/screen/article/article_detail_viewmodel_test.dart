import 'package:template/model/article.dart';
import 'package:template/repository/mock/mock_article_repository.dart';
import 'package:template/screen/article/article_detail_viewmodel.dart';
import 'package:test/test.dart';

void main() {
  test("Loading->success", () async {
    var articleRepository = MockArticleRepository();
    final viewModel = ArticleDetailViewModel(
      articleRepository: articleRepository,
    );
    expect(viewModel.uiState, UiState.initial);

    articleRepository.getByIdResult = Article(
        articleId: "articleId1",
        subject: "subject",
        date: DateTime.now(),
        body: "body",
        isNew: false,
        score: 0.2);
    await viewModel.fetchData("articleId1");

    expect(viewModel.uiState, UiState.success);
  });

  test("Loading->error", () async {
    var articleRepository = MockArticleRepository();
    final viewModel = ArticleDetailViewModel(
      articleRepository: articleRepository,
    );
    expect(viewModel.uiState, UiState.initial);

    articleRepository.getByIdError = Exception("Network error");
    await viewModel.fetchData("articleId1");
    expect(viewModel.uiState, UiState.error);
  });
}
