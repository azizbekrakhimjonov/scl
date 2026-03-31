enum UserRole { superAdmin, teacher, student }

class UserModel {
  final String id;
  final String name;
  final String login;
  final String password; // demo: saqlanadi
  final UserRole role;

  const UserModel({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.role,
  });

  bool get isSuperAdmin => role == UserRole.superAdmin;
  bool get isTeacher => role == UserRole.teacher;
  bool get isStudent => role == UserRole.student;
}
