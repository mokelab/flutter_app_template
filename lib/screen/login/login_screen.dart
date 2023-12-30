import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app_module.dart';
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
    ref.listenManual(viewModelProvider, (previous, next) {
      switch (next) {
        case UiState.idle:
        case UiState.loginInProgress:
          // nop
          break;
        case UiState.emptyInput:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            const snackBar =
                SnackBar(content: Text("Please input email/password"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            ref.read(viewModelProvider.notifier).moveToIdle();
          });
          break;
        case UiState.success:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            context.go("/top");
          });
          break;
        case UiState.error:
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
