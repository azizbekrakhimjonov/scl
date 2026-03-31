class TestQuestionModel {
  final String id;
  final String text;
  final List<String> variants; // A, B, C, D
  final int correctIndex; // 0-3

  const TestQuestionModel({
    required this.id,
    required this.text,
    required this.variants,
    required this.correctIndex,
  });
}

class TestModel {
  final String id;
  final String subjectId;
  final String title;
  final List<TestQuestionModel> questions;
  final DateTime createdAt;

  const TestModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.questions,
    required this.createdAt,
  });
}
