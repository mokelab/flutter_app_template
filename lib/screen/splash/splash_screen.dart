import 'package:flutter/material.dart';
import 'package:template/app_module.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _setup() async {
    final repo = AppModule.of(context).accountRepository;
    try {
      final account = await repo.loginWithStoredToken();
      // check account status
      if (account == null) {
        // go to login/signup screen
      }
    } catch (e) {
      // show error dialog or go to login/signup screen
    }
  }

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
