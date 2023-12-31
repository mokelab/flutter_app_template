import 'package:feature_article/article_detail_screen.dart';
import 'package:feature_article/article_list_screen.dart';
import 'package:feature_login/login_screen.dart';
import 'package:feature_login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/top_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRouteData>(path: "/")
class SplashRouteData extends GoRouteData {
  const SplashRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => SplashScreen(
        toLogin: () {
          const LoginRouteData().go(context);
        },
        toTop: () {
          const ArticleListRouteData().go(context);
        },
      );
}

@TypedGoRoute<LoginRouteData>(path: "/login")
class LoginRouteData extends GoRouteData {
  const LoginRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginScreen(
        toTop: () {
          const ArticleListRouteData().go(context);
        },
      );
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
    TypedStatefulShellBranch<SearchBranchData>(
      routes: [TypedGoRoute<SearchTopRouteData>(path: "/search")],
    ),
    TypedStatefulShellBranch<AccountBranchData>(
      routes: [TypedGoRoute<AccountRouteData>(path: "/account")],
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

class SearchBranchData extends StatefulShellBranchData {
  const SearchBranchData();
}

class AccountBranchData extends StatefulShellBranchData {
  const AccountBranchData();
}

class ArticleListRouteData extends GoRouteData {
  const ArticleListRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => ArticleListScreen(
        toDetail: (articleId) {
          ArticleDetailRouteData(id: articleId).go(context);
        },
      );
}

class ArticleDetailRouteData extends GoRouteData {
  const ArticleDetailRouteData({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ArticleDetailScreen(articleId: id);
}

class SearchTopRouteData extends GoRouteData {
  const SearchTopRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Center(
        child: Text("Search"),
      );
}

class AccountRouteData extends GoRouteData {
  const AccountRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Center(
        child: Text("Account"),
      );
}
