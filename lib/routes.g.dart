// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRouteData,
      $loginRouteData,
      $topRouteData,
    ];

RouteBase get $splashRouteData => GoRouteData.$route(
      path: '/',
      factory: $SplashRouteDataExtension._fromState,
    );

extension $SplashRouteDataExtension on SplashRouteData {
  static SplashRouteData _fromState(GoRouterState state) =>
      const SplashRouteData();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRouteData => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteDataExtension._fromState,
    );

extension $LoginRouteDataExtension on LoginRouteData {
  static LoginRouteData _fromState(GoRouterState state) =>
      const LoginRouteData();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $topRouteData => GoRouteData.$route(
      path: '/top',
      factory: $TopRouteDataExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'articles/:id',
          factory: $ArticleDetailRouteDataExtension._fromState,
        ),
      ],
    );

extension $TopRouteDataExtension on TopRouteData {
  static TopRouteData _fromState(GoRouterState state) => const TopRouteData();

  String get location => GoRouteData.$location(
        '/top',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ArticleDetailRouteDataExtension on ArticleDetailRouteData {
  static ArticleDetailRouteData _fromState(GoRouterState state) =>
      ArticleDetailRouteData(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/top/articles/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
