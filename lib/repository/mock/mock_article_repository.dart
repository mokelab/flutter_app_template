import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';

class MockArticleRepository implements ArticleRepository {
  List<Article>? getListResult;
  Exception? getListError;

  @override
  Future<List<Article>> getList(DateTime start) async {
    if (getListError != null) {
      throw getListError!;
    }
    return getListResult!;
  }

  @override
  Future<Article> getById(ArticleId articleId) async {
    return Article(
        articleId: articleId,
        subject: "Subject $articleId",
        date: DateTime.now(),
        body: "Body $articleId",
        isNew: true,
        score: 2.3);
  }
}
