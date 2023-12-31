import 'package:core_data_api/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/routes.dart';
import "login_viewmodel.dart";

final viewModelProvider = StateNotifierProvider<LoginViewModel, UiState>((ref) {
  final accountRepository = ref.read(accountRepositoryProvider);
  return LoginViewModel(accountRepository);
});

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: LoginScreenMain());
  }
}

class LoginScreenMain extends ConsumerStatefulWidget {
  const LoginScreenMain({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreenMain> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  ProviderSubscription? _subscription;

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    ref.read(viewModelProvider.notifier).login(email, password);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _subscription = ref.listenManual(viewModelProvider, (previous, next) {
      switch (next) {
        case Idle():
        case LoginInProgress():
          // nop
          break;
        case EmptyInput():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            const snackBar =
                SnackBar(content: Text("Please input email/password"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            ref.read(viewModelProvider.notifier).moveToIdle();
          });
          break;
        case Success():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            const ArticleListRouteData().go(context);
          });
          break;
        case Error():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text("Error"),
                actions: [],
              ),
            );
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _subscription?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Template app"),
              TextFormField(
                controller: _emailController,
                maxLines: 1,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                maxLines: 1,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              ElevatedButton(onPressed: _login, child: const Text("Log in"))
            ],
          )),
    ));
  }
}
