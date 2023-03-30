import 'package:flutter/foundation.dart';
import 'package:template/repository/account_repository.dart';

enum UiState {
  initial,
  showLogin,
  showTop,
}

class SplashViewModel extends ChangeNotifier {
  final AccountRepository accountRepository;

  SplashViewModel(this.accountRepository);

  UiState uiState = UiState.initial;

  Future<void> setup() async {
    try {
      final account = await accountRepository.loginWithStoredToken();
      // check account status
      if (account == null) {
        // go to login/signup screen
        uiState = UiState.showLogin;
        notifyListeners();
        return;
      }
      uiState = UiState.showTop;
      notifyListeners();
    } catch (e) {
      // show error dialog or go to login/signup screen
      uiState = UiState.showLogin;
      notifyListeners();
    }
  }
}
