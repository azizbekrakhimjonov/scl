import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/teacher/teacher_subjects_screen.dart';
import 'screens/super_admin/super_admin_screen.dart';
import 'screens/student/student_subjects_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCL Mobile',
      theme: AppTheme.lightTheme,
      home: const _RootScreen(),
    );
  }
}

class _RootScreen extends StatelessWidget {
  const _RootScreen();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (!auth.isLoggedIn) {
      return const LoginScreen();
    }
    final user = auth.currentUser!;
    if (user.isSuperAdmin) {
      return const SuperAdminScreen();
    }
    if (user.isTeacher) {
      return const TeacherSubjectsScreen();
    }
    return const StudentSubjectsScreen();
  }
}
