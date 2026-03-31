import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void login(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Demo: teacher login (login: teacher1, parol: 123)
  static UserModel get demoTeacher => const UserModel(
        id: 't1',
        name: 'Karimov Sardor',
        login: 'teacher1',
        password: '123',
        role: UserRole.teacher,
      );

  static UserModel get demoSuperAdmin => const UserModel(
        id: 'sa1',
        name: 'Super Admin',
        login: 'admin',
        password: 'admin',
        role: UserRole.superAdmin,
      );

  static UserModel get demoStudent => const UserModel(
        id: 's1',
        name: 'Aliyev Jasur',
        login: 'student1',
        password: '123',
        role: UserRole.student,
      );
}
