import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:template/app_module.dart';
import 'package:template/model/article.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
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
    final module = Provider.of<AppModule>(context, listen: false);
    try {
      final loadedArticles = await module.articleRepository().getList(key);
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
        return ListTile(title: Text(article.subject));
      }),
    );
  }
}
