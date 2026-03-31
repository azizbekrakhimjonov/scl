import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/subject_model.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _nameController = TextEditingController();
  String? _selectedTeacherId;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fan nomini kiriting')),
      );
      return;
    }
    final demoData = context.read<DemoDataProvider>();
    final id = demoData.nextSubjectId();
    demoData.addSubject(SubjectModel(
      id: id,
      name: name,
      teacherId: _selectedTeacherId,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fan qo\'shildi')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final demoData = context.watch<DemoDataProvider>();
    final teachers = demoData.teachers;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Fan qo\'shish',
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
              'Fan nomi',
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
                hintText: 'Masalan: Matematika',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'O\'qituvchi (ixtiyoriy)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String?>(
                  value: _selectedTeacherId,
                  isExpanded: true,
                  hint: const Text(
                    'O\'qituvchini tanlang',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('— Tanlanmagan —'),
                    ),
                    ...teachers.map((t) => DropdownMenuItem<String?>(
                          value: t.id,
                          child: Text(t.name),
                        )),
                  ],
                  onChanged: (v) {
                    setState(() => _selectedTeacherId = v);
                  },
                ),
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
