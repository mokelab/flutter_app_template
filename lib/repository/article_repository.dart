import 'package:template/model/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> getList(DateTime start);
}
