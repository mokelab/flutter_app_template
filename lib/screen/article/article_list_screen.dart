import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/app_module.dart';
import 'package:template/screen/article/article_list_viewmodel.dart';

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
        break;
      case UiState.success:
        break;
      case UiState.error:
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
        return ListView.builder(
          itemBuilder: ((context, index) {
            final article = viewModel.articles[index];
            return ListTile(title: Text(article.subject));
          }),
          itemCount: viewModel.articles.length,
        );
      case UiState.error:
        return Container(
            alignment: Alignment.center, child: const Text("Failed to load"));
    }
  }
}
