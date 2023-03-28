import 'package:template/model/account.dart';

abstract class AccountRepository {
  Future<Account?> loginWithStoredToken();
}
