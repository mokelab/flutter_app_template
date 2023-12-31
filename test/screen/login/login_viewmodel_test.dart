import 'package:template/model/account.dart';
import 'package:template/repository/mock/mock_account_repository.dart';
import 'package:template/screen/login/login_viewmodel.dart';
import 'package:test/test.dart';

void main() {
  test("login_success", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginResult = const Account(accountId: "account1");

    final viewModel = LoginViewModel(accountRepository);
    await viewModel.login("test@example.com", "password");
    expect(viewModel.state, isA<Success>());
  });

  test("login_empty_email", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginResult = const Account(accountId: "account1");

    final viewModel = LoginViewModel(accountRepository);
    await viewModel.login("", "password");
    expect(viewModel.state, isA<EmptyInput>());
    viewModel.moveToIdle();
    expect(viewModel.state, isA<Idle>());
  });

  test("login_empty_password", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginResult = const Account(accountId: "account1");

    final viewModel = LoginViewModel(accountRepository);
    await viewModel.login("test@example.com", "");
    expect(viewModel.state, isA<EmptyInput>());
    viewModel.moveToIdle();
    expect(viewModel.state, isA<Idle>());
  });

  test("login_repo_error", () async {
    final accountRepository = MockAccountRepository();
    accountRepository.loginError = Exception("API error");

    final viewModel = LoginViewModel(accountRepository);
    await viewModel.login("test@example.com", "password");
    expect(viewModel.state, isA<Error>());
  });
}
