class SubjectModel {
  final String id;
  final String name;
  final String? teacherId;

  const SubjectModel({
    required this.id,
    required this.name,
    this.teacherId,
  });
}
