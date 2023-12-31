import 'package:core_data_api/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<UiState> {
  final AccountRepository accountRepository;

  LoginViewModel(this.accountRepository) : super(const Idle());

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = const EmptyInput();
      return;
    }
    try {
      state = const LoginInProgress();

      final account = await accountRepository.login(email, password);
      // check account state if needed
      account.toString(); // suppress warning

      state = const Success();
    } catch (e) {
      // show error
      state = Error(e: e);
    }
  }

  void moveToIdle() {
    state = const Idle();
  }
}

sealed class UiState {
  const UiState();
}

class Idle extends UiState {
  const Idle() : super();
}

class EmptyInput extends UiState {
  const EmptyInput() : super();
}

class LoginInProgress extends UiState {
  const LoginInProgress() : super();
}

class Success extends UiState {
  const Success() : super();
}

class Error extends UiState {
  const Error({required this.e}) : super();
  final Object e;
}
