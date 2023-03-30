import "app_module.dart";
import "repository/account_repository.dart";
import "repository/mock/mock_account_repository.dart";

class MockAppModule implements AppModule {
  late AccountRepository _accountRepository;

  MockAppModule() {
    _accountRepository = MockAccountRepository();
  }

  @override
  AccountRepository accountRepository() => _accountRepository;
}
