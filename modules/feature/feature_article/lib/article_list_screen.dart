import 'package:core_data_api/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:core_model/article.dart';

class ArticleListScreen extends ConsumerStatefulWidget {
  const ArticleListScreen({
    super.key,
    required this.toDetail,
  });
  final Function(String articleId) toDetail;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleListScreenState();
}

class _ArticleListScreenState extends ConsumerState<ArticleListScreen> {
  final PagingController<DateTime, Article> _pagingController =
      PagingController(firstPageKey: DateTime.now());

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetch(pageKey);
    });
    super.initState();
  }

  Future<void> _fetch(DateTime key) async {
    final articleRepository = ref.read(articleRepositoryProvider);
    try {
      final loadedArticles = await articleRepository.getList(key);
      final hasNext = loadedArticles.isNotEmpty;
      if (hasNext) {
        _pagingController.appendPage(loadedArticles, loadedArticles.last.date);
      } else {
        _pagingController.appendLastPage(loadedArticles);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<DateTime, Article>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Article>(
          itemBuilder: (context, article, index) {
        return ListTile(
          title: Text(article.subject),
          onTap: () {
            widget.toDetail(article.articleId);
          },
        );
      }),
    );
  }
}
