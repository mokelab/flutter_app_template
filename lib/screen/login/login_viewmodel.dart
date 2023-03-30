import 'package:flutter/foundation.dart';
import 'package:template/repository/account_repository.dart';

enum UiState {
  idle,
  loginInProgress,
  success,
  error,
}

class LoginViewModel extends ChangeNotifier {
  final AccountRepository accountRepository;

  LoginViewModel(this.accountRepository);

  UiState uiState = UiState.idle;

  Future<void> login(String email, String password) async {
    try {
      uiState = UiState.loginInProgress;
      final account = await accountRepository.login(email, password);
      // check account state if needed

      uiState = UiState.success;
      notifyListeners();
    } catch (e) {
      // show error
      uiState = UiState.error;
    }
  }
}
