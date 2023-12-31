import 'package:core_model/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> getList(DateTime start);

  Future<Article> getById(ArticleId articleId);
}
