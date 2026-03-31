import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/user_model.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();
    if (name.isEmpty || login.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Barcha maydonlarni to\'ldiring')),
      );
      return;
    }
    final demoData = context.read<DemoDataProvider>();
    final existing = demoData.teacherByLogin(login);
    if (existing != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bunday login allaqachon mavjud')),
      );
      return;
    }
    final id = demoData.nextTeacherId();
    demoData.addTeacher(UserModel(
      id: id,
      name: name,
      login: login,
      password: password,
      role: UserRole.teacher,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('O\'qituvchi qo\'shildi')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'O\'qituvchi qo\'shish',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ism',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'O\'qituvchi ismi',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                hintText: 'Tizimga kirish uchun login',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Parol',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Parol',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Saqlash'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
