import 'package:flutter/material.dart';
import 'app_module.dart';
import 'repository/mock/mock_account_repository.dart';

import 'routes.dart';

void main() {
  final accountRepository = MockAccountRepository();
  runApp(
      AppModule(accountRepository: accountRepository, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App template",
      routes: routes,
    );
  }
}
