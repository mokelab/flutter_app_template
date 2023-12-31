import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/screen/article/article_detail_screen.dart';
import 'package:template/screen/article/article_list_screen.dart';
import 'package:template/screen/login/login_screen.dart';
import 'package:template/screen/top/top_screen.dart';

import 'screen/splash/splash_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRouteData>(path: "/")
class SplashRouteData extends GoRouteData {
  const SplashRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<LoginRouteData>(path: "/login")
class LoginRouteData extends GoRouteData {
  const LoginRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

@TypedStatefulShellRoute<TopRouteData>(
  branches: [
    TypedStatefulShellBranch<ArticleBranchData>(
      routes: [
        TypedGoRoute<ArticleListRouteData>(
          path: "/articles",
          routes: [
            TypedGoRoute<ArticleDetailRouteData>(
              path: ":id",
            ),
          ],
        ),
      ],
    ),
  ],
)
class TopRouteData extends StatefulShellRouteData {
  const TopRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return TopScreen(
      navigationShell: navigationShell,
    );
  }
}

class ArticleBranchData extends StatefulShellBranchData {
  const ArticleBranchData();
}

class ArticleListRouteData extends GoRouteData {
  const ArticleListRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ArticleListScreen();
}

class ArticleDetailRouteData extends GoRouteData {
  const ArticleDetailRouteData({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ArticleDetailScreen(articleId: id);
}
