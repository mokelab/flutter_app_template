import 'package:flutter/foundation.dart';
import 'package:template/repository/account_repository.dart';

enum UiState {
  idle,
  emptyInput,
  loginInProgress,
  success,
  error,
}

class LoginViewModel extends ChangeNotifier {
  final AccountRepository accountRepository;

  LoginViewModel(this.accountRepository);

  UiState uiState = UiState.idle;

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      uiState = UiState.emptyInput;
      notifyListeners();
      return;
    }
    try {
      uiState = UiState.loginInProgress;
      notifyListeners();

      final account = await accountRepository.login(email, password);
      // check account state if needed

      uiState = UiState.success;
      notifyListeners();
    } catch (e) {
      // show error
      uiState = UiState.error;
      notifyListeners();
    }
  }

  void moveToIdle() {
    uiState = UiState.idle;
    notifyListeners();
  }
}
