import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/repository/account_repository.dart';

enum UiState {
  initial,
  showLogin,
  showTop,
}

class SplashViewModel extends StateNotifier<UiState> {
  final AccountRepository accountRepository;

  SplashViewModel(this.accountRepository) : super(UiState.initial);

  Future<void> setup() async {
    try {
      final account = await accountRepository.loginWithStoredToken();
      // check account status
      if (account == null) {
        // go to login/signup screen
        state = UiState.showLogin;
        return;
      }
      state = UiState.showTop;
    } catch (e) {
      // show error dialog or go to login/signup screen
      state = UiState.showLogin;
    }
  }
}
