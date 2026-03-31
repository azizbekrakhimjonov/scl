import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../providers/demo_data_provider.dart';
import '../../models/test_model.dart';

class AddTestScreen extends StatefulWidget {
  final String subjectId;

  const AddTestScreen({super.key, required this.subjectId});

  @override
  State<AddTestScreen> createState() => _AddTestScreenState();
}

class _AddTestScreenState extends State<AddTestScreen> {
  final _testTitleController = TextEditingController();
  final List<_QuestionState> _questions = [
    _QuestionState(
      text: '',
      variants: ['', '', '', ''],
      correctIndex: 0,
    ),
  ];

  @override
  void dispose() {
    _testTitleController.dispose();
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(_QuestionState(
        text: '',
        variants: ['', '', '', ''],
        correctIndex: 0,
      ));
    });
  }

  void _save() {
    final title = _testTitleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test nomini kiriting')),
      );
      return;
    }
    final demoData = context.read<DemoDataProvider>();
    final testId = demoData.nextTestId();
    final questions = <TestQuestionModel>[];
    for (var i = 0; i < _questions.length; i++) {
      final q = _questions[i];
      if (q.text.trim().isEmpty) continue;
      final vars = q.variants.map((v) => v.trim().isEmpty ? 'Variant' : v).toList();
      questions.add(TestQuestionModel(
        id: demoData.nextQuestionId(),
        text: q.text.trim(),
        variants: vars,
        correctIndex: q.correctIndex.clamp(0, 3),
      ));
    }
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kamida bitta savol qo\'shing')),
      );
      return;
    }
    demoData.addTest(TestModel(
      id: testId,
      subjectId: widget.subjectId,
      title: title,
      questions: questions,
      createdAt: DateTime.now(),
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
          'Test qo\'shish',
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
              'Test nomi',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _testTitleController,
              decoration: const InputDecoration(
                hintText: 'Test sarlavhasi',
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(_questions.length, (i) {
              return _QuestionCard(
                index: i + 1,
                question: _questions[i],
                onChanged: (q) {
                  setState(() => _questions[i] = q);
                },
              );
            }),
            const SizedBox(height: 12),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _addQuestion,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppTheme.textSecondary),
                      const SizedBox(width: 8),
                      Text(
                        'Savol qo\'shish',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
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

class _QuestionState {
  final String text;
  final List<String> variants;
  final int correctIndex;

  _QuestionState({
    required this.text,
    required this.variants,
    required this.correctIndex,
  });
}

class _QuestionCard extends StatefulWidget {
  final int index;
  final _QuestionState question;
  final ValueChanged<_QuestionState> onChanged;

  const _QuestionCard({
    required this.index,
    required this.question,
    required this.onChanged,
  });

  @override
  State<_QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<_QuestionCard> {
  late TextEditingController _textController;
  late List<TextEditingController> _variantControllers;

  @override
  void initState() {
    super.initState();
    _correctIndex = widget.question.correctIndex;
    _textController = TextEditingController(text: widget.question.text);
    _variantControllers = widget.question.variants
        .map((v) => TextEditingController(text: v))
        .toList();
  }

  @override
  void dispose() {
    _textController.dispose();
    for (final c in _variantControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _emit() {
    widget.onChanged(_QuestionState(
      text: _textController.text,
      variants: _variantControllers.map((c) => c.text).toList(),
      correctIndex: _correctIndex,
    ));
  }

  int _correctIndex = 0;

  @override
  Widget build(BuildContext context) {
    _correctIndex = widget.question.correctIndex;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Savol ${widget.index}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Savol matni'),
              onChanged: (_) => _emit(),
            ),
            const SizedBox(height: 12),
            ...['A', 'B', 'C', 'D'].asMap().entries.map((e) {
              final i = e.key;
              return RadioListTile<int>(
                value: i,
                groupValue: _correctIndex,
                onChanged: (v) {
                  if (v != null) {
                    setState(() => _correctIndex = v);
                    _emit();
                  }
                },
                title: TextField(
                  controller: _variantControllers[i],
                  decoration: InputDecoration(
                    hintText: '${e.value} variant',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (_) => _emit(),
                ),
                activeColor: AppTheme.primaryPurple,
              );
            }),
          ],
        ),
      ),
    );
  }
}
