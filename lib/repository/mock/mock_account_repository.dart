import 'package:core_model/account.dart';
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

  Account? loginResult;
  Exception? loginError;

  @override
  Future<Account> login(String email, String password) async {
    if (loginError != null) {
      throw loginError!;
    }
    return loginResult!;
  }
}
