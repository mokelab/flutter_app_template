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

  static Article fromJson(Map<String, dynamic> data) {
    String articleId = data["article_id"] as String;
    String subject = data["subject"] as String;
    int dateMillisecs = data["date"] as int;
    String body = data["body"] as String;
    bool isNew = data["is_new"] as bool;
    double score = data["score"] + 0.0;
    return Article(
        articleId: articleId,
        subject: subject,
        date: DateTime.fromMillisecondsSinceEpoch(dateMillisecs),
        body: body,
        isNew: isNew,
        score: score);
  }
}
