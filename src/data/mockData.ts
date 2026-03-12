import { Subject, DidacticMaterial, Task, Test, StudentAnswer, TaskSubmission, User } from '@/types';

export const mockUsers: User[] = [
  { id: 'teacher-1', name: "Karimov Sardor", role: 'teacher', email: 'sardor@teacher.uz', password: '123456' },
  { id: 'student-1', name: "Aliyev Jasur", role: 'student', email: 'jasur@student.uz', password: '123456' },
  { id: 'student-2', name: "Rahimova Dilnoza", role: 'student', email: 'dilnoza@student.uz', password: '123456' },
  { id: 'student-3', name: "Toshmatov Bekzod", role: 'student', email: 'bekzod@student.uz', password: '123456' },
];

export const mockSubjects: Subject[] = [
  { id: 'sub-1', name: 'Matematika' },
  { id: 'sub-2', name: 'Fizika' },
  { id: 'sub-3', name: 'Ingliz tili' },
  { id: 'sub-4', name: 'Informatika' },
];

export const mockMaterials: DidacticMaterial[] = [
  { id: 'mat-1', title: 'Algebra asoslari', description: 'Algebraik ifodalar va tenglamalar haqida asosiy tushunchalar', fileName: 'algebra_asoslari.pdf', subjectId: 'sub-1' },
  { id: 'mat-2', title: 'Geometriya formulalari', description: 'Geometrik shakllar uchun asosiy formulalar to\'plami', fileName: 'geometriya.pdf', subjectId: 'sub-1' },
  { id: 'mat-3', title: 'Nyuton qonunlari', description: 'Mexanikaning asosiy qonunlari va misollar', fileName: 'nyuton.pdf', subjectId: 'sub-2' },
  { id: 'mat-4', title: 'English Grammar Basics', description: 'Tenses, articles, and sentence structure', fileName: 'grammar.pdf', subjectId: 'sub-3' },
  { id: 'mat-5', title: 'Python dasturlash', description: 'Python tilida dasturlash asoslari', fileName: 'python_intro.pdf', subjectId: 'sub-4' },
];

export const mockTasks: Task[] = [
  { id: 'task-1', title: 'Tenglamalar yechish', description: 'Berilgan 10 ta tenglamani yeching va javoblarni yuboring', subjectId: 'sub-1', createdAt: '2026-03-10' },
  { id: 'task-2', title: 'Fizika laboratoriya hisoboti', description: 'Nyuton qonunlari bo\'yicha tajriba hisobotini tayyorlang', subjectId: 'sub-2', fileName: 'lab_template.docx', createdAt: '2026-03-11' },
  { id: 'task-3', title: 'Essay yozing', description: 'Write a 300-word essay about your daily routine', subjectId: 'sub-3', createdAt: '2026-03-12' },
];

export const mockTests: Test[] = [
  {
    id: 'test-1',
    title: 'Algebra asoslari testi',
    subjectId: 'sub-1',
    createdAt: '2026-03-10',
    questions: [
      { id: 'q-1', questionText: '2x + 4 = 10 tenglamaning yechimi nima?', choices: ['x = 2', 'x = 3', 'x = 4', 'x = 5'], correctChoice: 1 },
      { id: 'q-2', questionText: '3² + 4² = ?', choices: ['7', '12', '25', '49'], correctChoice: 2 },
      { id: 'q-3', questionText: 'Qaysi biri algebraik ifoda?', choices: ['5 + 3 = 8', '2x + 1', '7 > 3', 'π = 3.14'], correctChoice: 1 },
      { id: 'q-4', questionText: '(a + b)² = ?', choices: ['a² + b²', 'a² + 2ab + b²', '2a + 2b', 'a² - b²'], correctChoice: 1 },
      { id: 'q-5', questionText: '12 ning 25% i nechaga teng?', choices: ['2', '3', '4', '6'], correctChoice: 1 },
    ],
  },
  {
    id: 'test-2',
    title: 'Nyuton qonunlari testi',
    subjectId: 'sub-2',
    createdAt: '2026-03-11',
    questions: [
      { id: 'q-6', questionText: 'Nyutonning birinchi qonuni nimani ta\'riflaydi?', choices: ['Inersiya', 'Kuch', 'Energiya', 'Tezlanish'], correctChoice: 0 },
      { id: 'q-7', questionText: 'F = m × a — bu Nyutonning nechinchi qonuni?', choices: ['Birinchi', 'Ikkinchi', 'Uchinchi', 'To\'rtinchi'], correctChoice: 1 },
      { id: 'q-8', questionText: 'Har bir ta\'sirga teng va qarama-qarshi reaktsiya bor. Bu qaysi qonun?', choices: ['Birinchi', 'Ikkinchi', 'Uchinchi', 'Gravitatsiya'], correctChoice: 2 },
    ],
  },
];

export const mockStudentAnswers: StudentAnswer[] = [
  { id: 'sa-1', studentId: 'student-1', studentName: 'Aliyev Jasur', testId: 'test-1', answers: { 'q-1': 1, 'q-2': 2, 'q-3': 1, 'q-4': 1, 'q-5': 1 }, score: 5, totalQuestions: 5, submittedAt: '2026-03-10' },
  { id: 'sa-2', studentId: 'student-2', studentName: 'Rahimova Dilnoza', testId: 'test-1', answers: { 'q-1': 1, 'q-2': 0, 'q-3': 1, 'q-4': 0, 'q-5': 1 }, score: 3, totalQuestions: 5, submittedAt: '2026-03-10' },
  { id: 'sa-3', studentId: 'student-3', studentName: 'Toshmatov Bekzod', testId: 'test-2', answers: { 'q-6': 0, 'q-7': 1, 'q-8': 2 }, score: 3, totalQuestions: 3, submittedAt: '2026-03-11' },
];

export const mockTaskSubmissions: TaskSubmission[] = [
  { id: 'ts-1', studentId: 'student-1', studentName: 'Aliyev Jasur', taskId: 'task-1', fileName: 'tenglamalar_javob.pdf', submittedAt: '2026-03-11', score: 85 },
  { id: 'ts-2', studentId: 'student-2', studentName: 'Rahimova Dilnoza', taskId: 'task-1', fileName: 'tenglamalar.pdf', submittedAt: '2026-03-11', score: 92 },
];
