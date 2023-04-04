import 'dart:convert';

import 'package:template/model/article.dart';
import 'package:test/test.dart';

void main() {
  test("fromJson", () {
    final jsonData = json.decode(str1);
    final article = Article.fromJson(jsonData);
    expect(article.articleId, "article001");
    expect(article.subject, "Article Subject");
    expect(article.date.year, 2023);
    expect(article.body, "Article body\n2nd line");
    expect(article.isNew, false);
    expect(article.score, 4.3);
  });

  test("fromJson_int score", () {
    final jsonData = json.decode(str2);
    final article = Article.fromJson(jsonData);
    expect(article.articleId, "article002");
    expect(article.subject, "Article Subject");
    expect(article.date.year, 2023);
    expect(article.body, "Article body\n2nd line");
    expect(article.isNew, false);
    expect(article.score, 3.0);
  });
}

const str1 = '''{
  "article_id": "article001",
  "subject": "Article Subject",
  "date": 1680585648852,
  "body": "Article body\\n2nd line",
  "is_new": false,
  "score": 4.3
}''';

const str2 = '''{
  "article_id": "article002",
  "subject": "Article Subject",
  "date": 1680585648852,
  "body": "Article body\\n2nd line",
  "is_new": false,
  "score": 3
}''';
