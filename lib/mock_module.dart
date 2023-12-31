import 'package:core_data_api/providers.dart';
import 'package:core_data_mock/mock_account_repository.dart';
import 'package:core_data_mock/mock_article_repository.dart';
import 'package:core_model/account.dart';
import 'package:core_model/article.dart';

final mockProviders = [
  accountRepositoryProvider.overrideWith((ref) {
    final accountRepository = MockAccountRepository();
    accountRepository.loginResult = const Account(accountId: "account1");

    return accountRepository;
  }),
  articleRepositoryProvider.overrideWith((ref) {
    final articleRepository = MockArticleRepository();
    articleRepository.getListResult = _makeArticles();
    articleRepository.getByIdResult = Article(
      articleId: "1",
      subject: "Detail Subject",
      date: DateTime.now(),
      body: "Detail body",
      isNew: true,
      score: 2.3,
    );

    return articleRepository;
  }),
];

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
