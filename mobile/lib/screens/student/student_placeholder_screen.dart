import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/auth_provider.dart';

/// Student ekrani — keyingi bosqichda fanlar, materiallar, testlar.
class StudentPlaceholderScreen extends StatelessWidget {
  const StudentPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talaba'),
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
                'Talaba paneli keyingi bosqichda qo\'shiladi:\n'
                '• Fanlar ro\'yxati\n'
                '• Materiallar, testlar, vazifalar',
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
