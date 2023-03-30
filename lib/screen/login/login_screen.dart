import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "login_viewmodel.dart";
import "../../app_module.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final module = Provider.of<AppModule>(context, listen: false);

    return MultiProvider(providers: [
      ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(module.accountRepository())),
    ], child: const LoginScreenMain());
  }
}

class LoginScreenMain extends StatefulWidget {
  const LoginScreenMain({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenMain> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    context.read<LoginViewModel>().login(email, password);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    switch (context.watch<LoginViewModel>().uiState) {
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
          context.read<LoginViewModel>().moveToIdle();
        });
        break;
      case UiState.success:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          Navigator.of(context).pushReplacementNamed("/top");
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
                  ));
        });
        break;
    }
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
