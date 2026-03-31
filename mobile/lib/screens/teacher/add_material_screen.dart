import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/material_model.dart';

class AddMaterialScreen extends StatefulWidget {
  final String subjectId;

  const AddMaterialScreen({super.key, required this.subjectId});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _fileNameController = TextEditingController(text: 'fayl.pdf');

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _fileNameController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final fileName = _fileNameController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sarlavha kiriting')),
      );
      return;
    }
    final demoData = context.read<DemoDataProvider>();
    final id = demoData.nextMaterialId();
    demoData.addMaterial(MaterialModel(
      id: id,
      subjectId: widget.subjectId,
      title: title,
      description: desc,
      fileName: fileName.isEmpty ? 'fayl.pdf' : fileName,
    ));
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
          'Material qo\'shish',
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
              'Sarlavha',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Material nomi',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tavsif',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                hintText: 'Qisqacha tavsif',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'Fayl nomi',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fileNameController,
              decoration: const InputDecoration(
                hintText: 'fayl.pdf',
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('Saqlash'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
