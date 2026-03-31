import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/user_model.dart';
import '../../models/subject_model.dart';
import 'add_teacher_screen.dart';
import 'add_subject_screen.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final demoData = context.watch<DemoDataProvider>();
    final teachers = demoData.teachers;
    final subjects = demoData.subjects;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Super Admin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppTheme.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: () => auth.logout(),
              icon: const Icon(Icons.exit_to_app, color: AppTheme.primaryPurple, size: 20),
              label: const Text(
                'Chiqish',
                style: TextStyle(
                  color: AppTheme.primaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryLight.withValues(alpha: 0.2),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person_outline, size: 22), text: 'O\'qituvchilar'),
            Tab(icon: Icon(Icons.menu_book_outlined, size: 22), text: 'Fanlar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TeachersTab(teachers: teachers),
          _SubjectsTab(subjects: subjects),
        ],
      ),
    );
  }
}

class _TeachersTab extends StatelessWidget {
  final List<UserModel> teachers;

  const _TeachersTab({required this.teachers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: teachers.length + 1,
      itemBuilder: (context, i) {
        if (i == teachers.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _AddCard(
              icon: Icons.person_add,
              label: 'O\'qituvchi qo\'shish',
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const AddTeacherScreen(),
                  ),
                );
              },
            ),
          );
        }
        final t = teachers[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryLight.withValues(alpha: 0.3),
              child: const Icon(Icons.person, color: AppTheme.primaryPurple),
            ),
            title: Text(
              t.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            subtitle: Text(
              'Login: ${t.login}',
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SubjectsTab extends StatelessWidget {
  final List<SubjectModel> subjects;

  const _SubjectsTab({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length + 1,
      itemBuilder: (context, i) {
        if (i == subjects.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _AddCard(
              icon: Icons.add,
              label: 'Fan qo\'shish',
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const AddSubjectScreen(),
                  ),
                );
              },
            ),
          );
        }
        final s = subjects[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryLight.withValues(alpha: 0.3),
              child: const Icon(Icons.menu_book, color: AppTheme.primaryPurple),
            ),
            title: Text(
              s.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AddCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AddCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: AppTheme.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
