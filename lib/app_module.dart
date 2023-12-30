import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository/article_repository.dart';
import "repository/account_repository.dart";

abstract class AppModule {
  AccountRepository accountRepository();
  ArticleRepository articleRepository();
}

final accountRepositoryProvider =
    Provider<AccountRepository>((_) => throw UnimplementedError());

final articleRepositoryProvider =
    Provider<ArticleRepository>((_) => throw UnimplementedError());
