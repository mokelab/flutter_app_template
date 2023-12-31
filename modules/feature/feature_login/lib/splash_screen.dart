import 'package:core_data_api/providers.dart';
import 'package:feature_login/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModelProvider = StateNotifierProvider<SplashViewModel, UiState>(
  (ref) {
    final accountRepository = ref.read(accountRepositoryProvider);
    return SplashViewModel(accountRepository);
  },
);

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.toLogin,
    required this.toTop,
  });
  final VoidCallback toLogin;
  final VoidCallback toTop;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: _SplashScreen(
      toLogin: toLogin,
      toTop: toTop,
    ));
  }
}

class _SplashScreen extends ConsumerStatefulWidget {
  const _SplashScreen({
    required this.toLogin,
    required this.toTop,
  });
  final VoidCallback toLogin;
  final VoidCallback toTop;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<_SplashScreen> {
  ProviderSubscription? _subscription;
  @override
  void initState() {
    _subscription = ref.listenManual(_viewModelProvider, (previous, next) {
      switch (next) {
        case Initial():
          break;
        case ShowLogin():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            widget.toLogin();
          });
          break;
        case ShowTop():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            widget.toTop();
          });
          break;
      }
    });
    ref.read(_viewModelProvider.notifier).setup();
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
