import 'package:template/model/article.dart';
import 'package:template/repository/mock/mock_article_repository.dart';
import 'package:template/screen/article/article_list_viewmodel.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("fetch->success", () async {
    final articleRepository = MockArticleRepository();

    final viewModel =
        ArticleListViewModel(articleRepository: articleRepository);
    expect(viewModel.uiState, UiState.initial);

    articleRepository.getListResult = [
      Article(
        articleId: "article1",
        subject: "subject1",
        date: DateTime.now(),
        body: "body1",
        isNew: false,
        score: 48.3,
      )
    ];
    await viewModel.fetch();
    expect(viewModel.uiState, UiState.success);
  });

  test("fetch->error", () async {
    final articleRepository = MockArticleRepository();

    final viewModel =
        ArticleListViewModel(articleRepository: articleRepository);
    expect(viewModel.uiState, UiState.initial);

    articleRepository.getListError = Exception("Network error");
    await viewModel.fetch();
    expect(viewModel.uiState, UiState.error);
  });
}
