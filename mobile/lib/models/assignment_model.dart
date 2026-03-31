class AssignmentModel {
  final String id;
  final String subjectId;
  final String title;
  final String description;
  final DateTime createdAt;

  const AssignmentModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}
