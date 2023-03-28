import 'package:flutter/material.dart';
import 'package:template/app_module.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  void _login() async {
    final repo = AppModule.of(context).accountRepository;

    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      final account = await repo.login(email, password);
      // check account state if needed
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed("/top");
    } catch (e) {
      // show error
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
