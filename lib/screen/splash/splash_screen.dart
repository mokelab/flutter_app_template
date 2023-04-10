import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:template/app_module.dart';
import 'package:template/screen/splash/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final module = Provider.of<AppModule>(context, listen: false);

    return MultiProvider(providers: [
      ChangeNotifierProvider<SplashViewModel>(
          create: (_) => SplashViewModel(module.accountRepository())),
    ], child: const SplashScreenMain());
  }
}

class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenMain> {
  @override
  void initState() {
    super.initState();
    Provider.of<SplashViewModel>(context, listen: false).setup();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    switch (context.watch<SplashViewModel>().uiState) {
      case UiState.initial:
        // Nop
        break;
      case UiState.showLogin:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          context.go("/login");
        });
        break;
      case UiState.showTop:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          context.go("/top");
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
