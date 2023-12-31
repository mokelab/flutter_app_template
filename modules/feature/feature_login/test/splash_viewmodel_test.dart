import 'package:test/test.dart';
import 'package:core_model/account.dart';
import 'package:core_data_mock/mock_account_repository.dart';
import 'package:feature_login/splash_viewmodel.dart';

void main() {
  test("setup_first_launch", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginWithStoredTokenResult = null;

    final viewModel = SplashViewModel(accountRepository);
    await viewModel.setup();
    expect(viewModel.state, isA<ShowLogin>());
  });

  test("setup_already_login", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginWithStoredTokenResult =
        const Account(accountId: "account1");

    final viewModel = SplashViewModel(accountRepository);
    await viewModel.setup();
    expect(viewModel.state, isA<ShowTop>());
  });

  test("setup_error", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginWithStoredTokenError = Exception("API call error");

    final viewModel = SplashViewModel(accountRepository);
    await viewModel.setup();
    expect(viewModel.state, isA<ShowLogin>());
  });
}
