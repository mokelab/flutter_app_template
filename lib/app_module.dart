import 'package:flutter/material.dart';
import 'package:template/repository/account_repository.dart';

class AppModule extends InheritedWidget {
  final AccountRepository accountRepository;

  const AppModule(
      {required this.accountRepository, required super.child, super.key});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
