import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/material_model.dart';
import '../../models/test_model.dart';
import '../../models/assignment_model.dart';
import 'add_material_screen.dart';
import 'add_test_screen.dart';
import 'add_assignment_screen.dart';

class TeacherSubjectDetailScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;

  const TeacherSubjectDetailScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  State<TeacherSubjectDetailScreen> createState() =>
      _TeacherSubjectDetailScreenState();
}

class _TeacherSubjectDetailScreenState extends State<TeacherSubjectDetailScreen>
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
            Tab(
              icon: Icon(Icons.description_outlined, size: 22),
              text: 'Materiallar',
            ),
            Tab(
              icon: Icon(Icons.assignment_outlined, size: 22),
              text: 'Testlar',
            ),
            Tab(
              icon: Icon(Icons.check_box_outlined, size: 22),
              text: 'Vazifalar',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MaterialsTab(
            subjectId: widget.subjectId,
            materials: materials,
          ),
          _TestsTab(
            subjectId: widget.subjectId,
            tests: tests,
          ),
          _AssignmentsTab(
            subjectId: widget.subjectId,
            assignments: assignments,
          ),
        ],
      ),
    );
  }
}

class _MaterialsTab extends StatelessWidget {
  final String subjectId;
  final List<MaterialModel> materials;

  const _MaterialsTab({required this.subjectId, required this.materials});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...materials.map((m) => _MaterialCard(material: m)),
        const SizedBox(height: 12),
        _AddCard(
          icon: Icons.add,
          label: 'Material qo\'shish',
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => AddMaterialScreen(subjectId: subjectId),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final MaterialModel material;

  const _MaterialCard({required this.material});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              material.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              material.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.download, size: 18, color: AppTheme.primaryPurple),
                const SizedBox(width: 6),
                Text(
                  material.fileName,
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
  }
}

class _TestsTab extends StatelessWidget {
  final String subjectId;
  final List<TestModel> tests;

  const _TestsTab({required this.subjectId, required this.tests});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...tests.map((t) => _TestCard(test: t)),
        const SizedBox(height: 12),
        _AddCard(
          icon: Icons.add,
          label: 'Test qo\'shish',
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => AddTestScreen(subjectId: subjectId),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TestCard extends StatelessWidget {
  final TestModel test;

  const _TestCard({required this.test});

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${test.createdAt.year}-${test.createdAt.month.toString().padLeft(2, '0')}-${test.createdAt.day.toString().padLeft(2, '0')}';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              test.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${test.questions.length} ta savol · $dateStr',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentsTab extends StatelessWidget {
  final String subjectId;
  final List<AssignmentModel> assignments;

  const _AssignmentsTab({required this.subjectId, required this.assignments});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...assignments.map((a) => _AssignmentCard(assignment: a)),
        const SizedBox(height: 12),
        _AddCard(
          icon: Icons.add,
          label: 'Vazifa qo\'shish',
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => AddAssignmentScreen(subjectId: subjectId),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;

  const _AssignmentCard({required this.assignment});

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${assignment.createdAt.year}-${assignment.createdAt.month.toString().padLeft(2, '0')}-${assignment.createdAt.day.toString().padLeft(2, '0')}';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              assignment.description,
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
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
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
