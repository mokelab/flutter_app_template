import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as p;
import 'app_module.dart';

import 'mock_module.dart';
import 'routes.dart';

void main() {
  runApp(
    p.MultiProvider(
      providers: [
        p.Provider<AppModule>(create: (_) => MockAppModule()),
      ],
      child: ProviderScope(
        overrides: mockProviders,
        child: const MainApp(),
      ),
    ),
  );
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
