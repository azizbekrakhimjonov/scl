import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/material_model.dart';
import '../../models/test_model.dart';
import '../../models/assignment_model.dart';
import 'student_test_screen.dart';
import 'student_submit_assignment_screen.dart';

class StudentSubjectDetailScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;

  const StudentSubjectDetailScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  State<StudentSubjectDetailScreen> createState() =>
      _StudentSubjectDetailScreenState();
}

class _StudentSubjectDetailScreenState extends State<StudentSubjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    final materials = demoData.materialsForSubject(widget.subjectId);
    final tests = demoData.testsForSubject(widget.subjectId);
    final assignments = demoData.assignmentsForSubject(widget.subjectId);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.subjectName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppTheme.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () => auth.logout(),
              icon: const Icon(Icons.exit_to_app, color: AppTheme.primaryPurple, size: 18),
              label: const Text(
                'Chiqish',
                style: TextStyle(
                  color: AppTheme.primaryPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryLight.withValues(alpha: 0.2),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.description_outlined, size: 22), text: 'Materiallar'),
            Tab(icon: Icon(Icons.assignment_outlined, size: 22), text: 'Testlar'),
            Tab(icon: Icon(Icons.check_box_outlined, size: 22), text: 'Vazifalar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MaterialsTab(materials: materials),
          _TestsTab(tests: tests),
          _AssignmentsTab(assignments: assignments),
        ],
      ),
    );
  }
}

class _MaterialsTab extends StatelessWidget {
  final List<MaterialModel> materials;

  const _MaterialsTab({required this.materials});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      itemBuilder: (context, i) {
        final m = materials[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  m.description,
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.download, size: 18, color: AppTheme.primaryPurple),
                    const SizedBox(width: 6),
                    Text(
                      m.fileName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.primaryPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TestsTab extends StatelessWidget {
  final List<TestModel> tests;

  const _TestsTab({required this.tests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tests.length,
      itemBuilder: (context, i) {
        final t = tests[i];
        final dateStr =
            '${t.createdAt.year}-${t.createdAt.month.toString().padLeft(2, '0')}-${t.createdAt.day.toString().padLeft(2, '0')}';
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${t.questions.length} ta savol · $dateStr',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => StudentTestScreen(test: t),
                      ),
                    );
                  },
                  child: const Text('Boshlash'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AssignmentsTab extends StatelessWidget {
  final List<AssignmentModel> assignments;

  const _AssignmentsTab({required this.assignments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, i) {
        final a = assignments[i];
        final dateStr =
            '${a.createdAt.year}-${a.createdAt.month.toString().padLeft(2, '0')}-${a.createdAt.day.toString().padLeft(2, '0')}';
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        a.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dateStr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => StudentSubmitAssignmentScreen(assignment: a),
                      ),
                    );
                  },
                  child: const Text('Topshirish'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
