import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../models/test_model.dart';
import 'student_test_result_screen.dart';

class StudentTestScreen extends StatefulWidget {
  final TestModel test;

  const StudentTestScreen({super.key, required this.test});

  @override
  State<StudentTestScreen> createState() => _StudentTestScreenState();
}

class _StudentTestScreenState extends State<StudentTestScreen> {
  int _currentIndex = 0;
  final List<int?> _answers = []; // selected variant index per question

  @override
  void initState() {
    super.initState();
    _answers.addAll(List.filled(widget.test.questions.length, null));
  }

  int get _answeredCount => _answers.where((a) => a != null).length;

  void _goNext() {
    if (_currentIndex < widget.test.questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _finishTest();
    }
  }

  void _goPrev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  void _finishTest() {
    int correct = 0;
    for (var i = 0; i < widget.test.questions.length; i++) {
      if (_answers[i] == widget.test.questions[i].correctIndex) correct++;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => StudentTestResultScreen(
          testTitle: widget.test.title,
          total: widget.test.questions.length,
          correct: correct,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.test.questions;
    final q = questions[_currentIndex];
    final total = questions.length;
    final isLast = _currentIndex == total - 1;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.test.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Savol ${_currentIndex + 1}/$total',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '$_answeredCount ta javob',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: ( _currentIndex + 1) / total,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryPurple),
              minHeight: 4,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                q.text,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...['A', 'B', 'C', 'D'].asMap().entries.map((e) {
              final i = e.key;
              final selected = _answers[_currentIndex] == i;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      setState(() => _answers[_currentIndex] = i);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? AppTheme.primaryPurple : Colors.grey.shade300,
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: selected
                                ? AppTheme.primaryPurple
                                : Colors.grey.shade200,
                            child: Text(
                              e.value,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selected ? Colors.white : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              i < q.variants.length ? q.variants[i] : '',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _currentIndex > 0 ? _goPrev : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Oldingi'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goNext,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(isLast ? 'Yakunlash' : 'Keyingi'),
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
