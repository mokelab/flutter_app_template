import 'package:template/model/account.dart';
import 'package:template/repository/account_repository.dart';

class MockAccountRepository implements AccountRepository {
  Account? loginWithStoredTokenResult;
  Exception? loginWithStoredTokenError;

  @override
  Future<Account?> loginWithStoredToken() async {
    if (loginWithStoredTokenError != null) {
      throw loginWithStoredTokenError!;
    }
    return loginWithStoredTokenResult;
  }

  @override
  Future<Account> login(String email, String password) async {
    return const Account(accountId: "mockAccount");
  }
}
