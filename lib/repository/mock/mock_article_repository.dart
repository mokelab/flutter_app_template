import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';

class MockArticleRepository implements ArticleRepository {
  List<Article>? getListResult;

  @override
  Future<List<Article>> getList(DateTime start) async {
    return getListResult!;
  }
}
