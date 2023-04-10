import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_module.dart';

import 'mock_module.dart';
import 'routes.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<AppModule>(create: (_) => MockAppModule()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
