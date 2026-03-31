import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/auth_provider.dart';

/// Super Admin ekrani — keyingi bosqichda o'qituvchilar va fanlarni boshqarish.
class SuperAdminPlaceholderScreen extends StatelessWidget {
  const SuperAdminPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin'),
        actions: [
          TextButton(
            onPressed: () => auth.logout(),
            child: const Text('Chiqish'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Salom, ${user.name}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Super Admin paneli keyingi bosqichda qo\'shiladi:\n'
                '• O\'qituvchilar qo\'shish\n'
                '• Fanlar qo\'shish\n'
                '• O\'qituvchilarni fanlarga biriktirish',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
