export type UserRole = 'teacher' | 'student';

export interface User {
  id: string;
  name: string;
  role: UserRole;
}

export interface Subject {
  id: string;
  name: string;
}

export interface DidacticMaterial {
  id: string;
  title: string;
  description: string;
  fileName: string;
  subjectId: string;
}

export interface Task {
  id: string;
  title: string;
  description: string;
  fileName?: string;
  subjectId: string;
  createdAt: string;
}

export interface Test {
  id: string;
  title: string;
  subjectId: string;
  createdAt: string;
  questions: Question[];
}

export interface Question {
  id: string;
  questionText: string;
  choices: string[];
  correctChoice: number; // index
}

export interface StudentAnswer {
  id: string;
  studentId: string;
  studentName: string;
  testId: string;
  answers: Record<string, number>; // questionId -> choiceIndex
  score: number;
  totalQuestions: number;
  submittedAt: string;
}

export interface TaskSubmission {
  id: string;
  studentId: string;
  studentName: string;
  taskId: string;
  fileName: string;
  submittedAt: string;
  score?: number;
}
