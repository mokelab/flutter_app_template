import 'package:core_data_api/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/routes.dart';
import 'package:template/screen/splash/splash_viewmodel.dart';

final _viewModelProvider = StateNotifierProvider<SplashViewModel, UiState>(
  (ref) {
    final accountRepository = ref.read(accountRepositoryProvider);
    return SplashViewModel(accountRepository);
  },
);

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: SplashScreenMain());
  }
}

class SplashScreenMain extends ConsumerStatefulWidget {
  const SplashScreenMain({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreenMain> {
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
            const LoginRouteData().go(context);
          });
          break;
        case ShowTop():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            const ArticleListRouteData().go(context);
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
