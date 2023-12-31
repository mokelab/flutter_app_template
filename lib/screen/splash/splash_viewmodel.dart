import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/repository/account_repository.dart';

class SplashViewModel extends StateNotifier<UiState> {
  final AccountRepository accountRepository;

  SplashViewModel(this.accountRepository) : super(const Initial());

  Future<void> setup() async {
    try {
      final account = await accountRepository.loginWithStoredToken();
      // check account status
      if (account == null) {
        // go to login/signup screen
        state = const ShowLogin();
        return;
      }
      state = const ShowTop();
    } catch (e) {
      // show error dialog or go to login/signup screen
      state = const ShowLogin();
    }
  }
}

sealed class UiState {
  const UiState();
}

class Initial extends UiState {
  const Initial() : super();
}

class ShowLogin extends UiState {
  const ShowLogin() : super();
}

class ShowTop extends UiState {
  const ShowTop() : super();
}
