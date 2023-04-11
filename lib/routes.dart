import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/screen/article/article_detail_screen.dart';
import 'package:template/screen/login/login_screen.dart';
import 'package:template/screen/top/top_screen.dart';

import 'screen/splash/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          const MaterialPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
        path: '/top',
        pageBuilder: (context, state) => const MaterialPage(child: TopScreen()),
        routes: [
          GoRoute(
            path: 'articles/:id',
            pageBuilder: (context, state) => MaterialPage(
              child: ArticleDetailScreen(articleId: state.params["id"]!),
            ),
          ),
        ]),
  ],
);
