import 'package:core_model/article.dart';
import 'package:core_data_mock/mock_article_repository.dart';
import 'package:feature_article/article_detail_viewmodel.dart';
import 'package:test/test.dart';

void main() {
  test("Loading->success", () async {
    var articleRepository = MockArticleRepository();
    final viewModel = ArticleDetailViewModel(
      articleRepository: articleRepository,
    );
    expect(viewModel.state, isA<Initial>());

    articleRepository.getByIdResult = Article(
        articleId: "articleId1",
        subject: "subject",
        date: DateTime.now(),
        body: "body",
        isNew: false,
        score: 0.2);
    await viewModel.fetchData("articleId1");

    expect(viewModel.state, isA<Success>());
  });

  test("Loading->error", () async {
    var articleRepository = MockArticleRepository();
    final viewModel = ArticleDetailViewModel(
      articleRepository: articleRepository,
    );
    expect(viewModel.state, isA<Initial>());

    articleRepository.getByIdError = Exception("Network error");
    await viewModel.fetchData("articleId1");
    expect(viewModel.state, isA<Error>());
  });
}
