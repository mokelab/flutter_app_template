import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/repository/account_repository.dart';

enum UiState {
  idle,
  emptyInput,
  loginInProgress,
  success,
  error,
}

class LoginViewModel extends StateNotifier<UiState> {
  final AccountRepository accountRepository;

  LoginViewModel(this.accountRepository) : super(UiState.idle);

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = UiState.emptyInput;
      return;
    }
    try {
      state = UiState.loginInProgress;

      final account = await accountRepository.login(email, password);
      // check account state if needed

      state = UiState.success;
    } catch (e) {
      // show error
      state = UiState.error;
    }
  }

  void moveToIdle() {
    state = UiState.idle;
  }
}
