typedef ArticleId = String;

class Article {
  final ArticleId articleId;
  final String subject;
  final DateTime date;
  final String body;
  final bool isNew;
  final double score;

  const Article({
    required this.articleId,
    required this.subject,
    required this.date,
    required this.body,
    required this.isNew,
    required this.score,
  });
}
