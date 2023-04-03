import 'repository/article_repository.dart';
import "repository/account_repository.dart";

abstract class AppModule {
  AccountRepository accountRepository();
  ArticleRepository articleRepository();
}
