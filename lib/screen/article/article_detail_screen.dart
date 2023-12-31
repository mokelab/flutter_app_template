import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_model/article.dart';

import '../../app_module.dart';
import 'article_detail_viewmodel.dart';

final _viewModelProvider =
    StateNotifierProvider<ArticleDetailViewModel, UiState>((ref) {
  final articleRepository = ref.read(articleRepositoryProvider);
  return ArticleDetailViewModel(articleRepository: articleRepository);
});

class ArticleDetailScreen extends StatelessWidget {
  final ArticleId articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _ArticleDetailScreen(articleId: articleId),
    );
  }
}

class _ArticleDetailScreen extends ConsumerStatefulWidget {
  final ArticleId articleId;

  const _ArticleDetailScreen({required this.articleId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleListScreenState();
}

class _ArticleListScreenState extends ConsumerState<_ArticleDetailScreen> {
  ProviderSubscription? _subscription;
  @override
  void initState() {
    _subscription = ref.listenManual(_viewModelProvider, (previous, next) {
      switch (next) {
        case Initial():
        case Loading():
        case Success():
        case Error():
          break;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(_viewModelProvider.notifier);
      viewModel.fetchData(widget.articleId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(_viewModelProvider);
    switch (uiState) {
      case Initial():
      case Loading():
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case Success(article: final article):
        return Scaffold(
          appBar: AppBar(
            title: Text(article.subject),
          ),
          body: Center(
            child: Text(article.body),
          ),
        );
      case Error():
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
