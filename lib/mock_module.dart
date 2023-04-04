import 'package:template/model/account.dart';
import 'package:template/model/article.dart';
import 'package:template/repository/article_repository.dart';
import 'package:template/repository/mock/mock_article_repository.dart';

import "app_module.dart";
import "repository/account_repository.dart";
import "repository/mock/mock_account_repository.dart";

class MockAppModule implements AppModule {
  late AccountRepository _accountRepository;
  late ArticleRepository _articleRepository;

  MockAppModule() {
    final accountRepository = MockAccountRepository();
    accountRepository.loginResult = const Account(accountId: "account1");
    final articleRepository = MockArticleRepository();
    articleRepository.getListResult = _makeArticles();

    _accountRepository = accountRepository;
    _articleRepository = articleRepository;
  }

  List<Article> _makeArticles() {
    List<Article> list = [];
    for (var i = 0; i < 20; i++) {
      list.add(Article(
        articleId: "article$i",
        subject: "Article $i",
        date: DateTime.now(),
        body: "Body $i",
        isNew: false,
        score: i * 0.3,
      ));
    }
    return list;
  }

  @override
  AccountRepository accountRepository() => _accountRepository;

  @override
  ArticleRepository articleRepository() => _articleRepository;
}
