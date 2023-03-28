import 'package:template/model/account.dart';
import 'package:template/repository/account_repository.dart';

class MockAccountRepository implements AccountRepository {
  @override
  Future<Account?> loginWithStoredToken() async {
    return null;
  }
}
