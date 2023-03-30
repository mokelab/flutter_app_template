import "repository/account_repository.dart";

abstract class AppModule {
  AccountRepository accountRepository();
}
