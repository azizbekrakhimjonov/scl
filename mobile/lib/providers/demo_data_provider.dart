import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/subject_model.dart';
import '../models/material_model.dart';
import '../models/test_model.dart';
import '../models/assignment_model.dart';

class DemoDataProvider extends ChangeNotifier {
  final List<UserModel> _teachers = [
    const UserModel(
      id: 't1',
      name: 'Karimov Sardor',
      login: 'teacher1',
      password: '123',
      role: UserRole.teacher,
    ),
  ];

  final List<SubjectModel> _subjects = [
    const SubjectModel(id: '1', name: 'Matematika', teacherId: 't1'),
    const SubjectModel(id: '2', name: 'Fizika', teacherId: 't1'),
    const SubjectModel(id: '3', name: 'Ingliz tili', teacherId: 't1'),
    const SubjectModel(id: '4', name: 'Informatika', teacherId: 't1'),
  ];

  final List<MaterialModel> _materials = [
    const MaterialModel(
      id: 'm1',
      subjectId: '1',
      title: 'Algebra asoslari',
      description: 'Algebraik ifodalar va tenglamalar haqida asosiy tushunchalar',
      fileName: 'algebra_asoslari.pdf',
    ),
    const MaterialModel(
      id: 'm2',
      subjectId: '1',
      title: 'Geometriya formulalari',
      description: 'Geometrik shakllar uchun asosiy formulalar to\'plami',
      fileName: 'geometriya.pdf',
    ),
  ];

  final List<TestModel> _tests = [
    TestModel(
      id: 'test1',
      subjectId: '1',
      title: 'Algebra asoslari testi',
      questions: const [
        TestQuestionModel(
          id: 'q1',
          text: '2x + 4 = 10 tenglamaning yechimi nima?',
          variants: ['x = 2', 'x = 3', 'x = 4', 'x = 5'],
          correctIndex: 0,
        ),
        TestQuestionModel(
          id: 'q2',
          text: '3x - 6 = 0 bo\'lsa, x = ?',
          variants: ['x = 1', 'x = 2', 'x = 3', 'x = 4'],
          correctIndex: 1,
        ),
        TestQuestionModel(
          id: 'q3',
          text: 'x + 5 = 12 tenglamada x ning qiymati?',
          variants: ['5', '6', '7', '8'],
          correctIndex: 2,
        ),
        TestQuestionModel(
          id: 'q4',
          text: '4x = 20 bo\'lsa, x = ?',
          variants: ['3', '4', '5', '6'],
          correctIndex: 2,
        ),
        TestQuestionModel(
          id: 'q5',
          text: 'x - 3 = 7 tenglamaning yechimi?',
          variants: ['x = 9', 'x = 10', 'x = 11', 'x = 12'],
          correctIndex: 1,
        ),
      ],
      createdAt: DateTime(2026, 3, 10),
    ),
  ];

  final List<AssignmentModel> _assignments = [
    AssignmentModel(
      id: 'a1',
      subjectId: '1',
      title: 'Tenglamalar yechish',
      description: 'Berilgan 10 ta tenglamani yeching va javoblarni yuboring...',
      createdAt: DateTime(2026, 3, 10),
    ),
  ];

  List<UserModel> get teachers => List.unmodifiable(_teachers);
  List<SubjectModel> get subjects => List.unmodifiable(_subjects);
  List<SubjectModel> subjectsForTeacher(String teacherId) =>
      _subjects.where((s) => s.teacherId == teacherId).toList();

  List<MaterialModel> materialsForSubject(String subjectId) =>
      _materials.where((m) => m.subjectId == subjectId).toList();

  List<TestModel> testsForSubject(String subjectId) =>
      _tests.where((t) => t.subjectId == subjectId).toList();

  List<AssignmentModel> assignmentsForSubject(String subjectId) =>
      _assignments.where((a) => a.subjectId == subjectId).toList();

  SubjectModel? subjectById(String id) {
    try {
      return _subjects.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  void addMaterial(MaterialModel m) {
    _materials.add(m);
    notifyListeners();
  }

  void addTest(TestModel t) {
    _tests.add(t);
    notifyListeners();
  }

  void addAssignment(AssignmentModel a) {
    _assignments.add(a);
    notifyListeners();
  }

  void addTeacher(UserModel teacher) {
    _teachers.add(teacher);
    notifyListeners();
  }

  void addSubject(SubjectModel subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  UserModel? teacherByLogin(String login) {
    try {
      return _teachers.firstWhere((t) => t.login == login);
    } catch (_) {
      return null;
    }
  }

  static String _newId(List<String> ids, String prefix) {
    int n = 1;
    while (ids.contains('$prefix$n')) {
      n++;
    }
    return '$prefix$n';
  }

  String nextSubjectId() =>
      _newId(_subjects.map((s) => s.id).toList(), '');
  String nextTeacherId() =>
      _newId(_teachers.map((t) => t.id).toList(), 't');
  String nextMaterialId() =>
      _newId(_materials.map((m) => m.id).toList(), 'm');
  String nextTestId() => _newId(_tests.map((t) => t.id).toList(), 'test');
  String nextAssignmentId() =>
      _newId(_assignments.map((a) => a.id).toList(), 'a');
  String nextQuestionId() {
    final allIds = <String>[];
    for (final t in _tests) {
      for (final q in t.questions) {
        allIds.add(q.id);
      }
    }
    return _newId(allIds, 'q');
  }
}
