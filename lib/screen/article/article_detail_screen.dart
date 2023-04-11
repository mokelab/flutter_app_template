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
    ], child: _ArticleDetailScreen());
  }
}

class _ArticleDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<_ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ArticleDetailViewModel>(context);
    switch (viewModel.uiState) {
      case UiState.initial:
      case UiState.loading:
        return const Center(child: CircularProgressIndicator());
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
