import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/app_module.dart';
import 'package:template/screen/article/article_list_viewmodel.dart';
import 'package:template/widget/pagination_controller.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final module = Provider.of<AppModule>(context, listen: false);

    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => ArticleListViewModel(
              articleRepository: module.articleRepository()))
    ], child: _ArticleListScreen());
  }
}

class _ArticleListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<_ArticleListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.watch<ArticleListViewModel>();
    switch (viewModel.uiState) {
      case UiState.initial:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel.fetch();
        });
        break;
      case UiState.loading:
      case UiState.success:
      case UiState.error:
      case UiState.loadingMore:
        break;
      case UiState.fetchMoreError:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          const snackBar = SnackBar(content: Text("Failed to load articles"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          viewModel.notifyFetchMoreErrorConsumed();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ArticleListViewModel>();

    switch (viewModel.uiState) {
      case UiState.initial:
      case UiState.loading:
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      case UiState.success:
      case UiState.loadingMore:
      case UiState.fetchMoreError:
        return ListView.builder(
          itemBuilder: ((context, index) {
            final article = viewModel.articles[index];
            return ListTile(title: Text(article.subject));
          }),
          itemCount: viewModel.articles.length,
          controller: PaginationController(() async {
            viewModel.fetchMore();
          }),
        );
      case UiState.error:
        return Container(
            alignment: Alignment.center, child: const Text("Failed to load"));
    }
  }
}
