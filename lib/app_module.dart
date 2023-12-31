import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository/article_repository.dart';
import "repository/account_repository.dart";

final accountRepositoryProvider =
    Provider<AccountRepository>((_) => throw UnimplementedError());

final articleRepositoryProvider =
    Provider<ArticleRepository>((_) => throw UnimplementedError());
