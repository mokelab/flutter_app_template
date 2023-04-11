import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/model/article.dart';

import '../../app_module.dart';
import 'article_detail_viewmodel.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleId articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final module = Provider.of<AppModule>(context, listen: false);
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => ArticleDetailViewModel(
                articleRepository: module.articleRepository(),
              )),
    ], child: _ArticleDetailScreen(articleId: articleId));
  }
}

class _ArticleDetailScreen extends StatefulWidget {
  final ArticleId articleId;

  const _ArticleDetailScreen({required this.articleId});
  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<_ArticleDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.watch<ArticleDetailViewModel>();
    switch (viewModel.uiState) {
      case UiState.initial:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel.fetchData(widget.articleId);
        });
        break;
      case UiState.loading:
      case UiState.success:
      case UiState.error:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ArticleDetailViewModel>();
    switch (viewModel.uiState) {
      case UiState.initial:
      case UiState.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case UiState.success:
        return Scaffold(
          appBar: AppBar(
            title: Text(viewModel.article!.subject),
          ),
          body: Center(
            child: Text(viewModel.article!.body),
          ),
        );
      case UiState.error:
        return _buildError(context);
    }
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Error'),
      ),
    );
  }
}
