import React, { createContext, useContext, useState, ReactNode } from 'react';
import { User, Subject, DidacticMaterial, Task, Test, StudentAnswer, TaskSubmission } from '@/types';
import { mockUsers, mockSubjects, mockMaterials, mockTasks, mockTests, mockStudentAnswers, mockTaskSubmissions } from '@/data/mockData';

interface AppState {
  currentUser: User;
  subjects: Subject[];
  materials: DidacticMaterial[];
  tasks: Task[];
  tests: Test[];
  studentAnswers: StudentAnswer[];
  taskSubmissions: TaskSubmission[];
  switchRole: () => void;
  submitTestAnswers: (testId: string, answers: Record<string, number>) => number;
  submitTask: (taskId: string, fileName: string) => void;
  addMaterial: (material: Omit<DidacticMaterial, 'id'>) => void;
  addTask: (task: Omit<Task, 'id' | 'createdAt'>) => void;
  addTest: (test: Omit<Test, 'id' | 'createdAt'>) => void;
}

const AppContext = createContext<AppState | null>(null);

export function AppProvider({ children }: { children: ReactNode }) {
  const [userIndex, setUserIndex] = useState(0);
  const [subjects] = useState(mockSubjects);
  const [materials, setMaterials] = useState(mockMaterials);
  const [tasks, setTasks] = useState(mockTasks);
  const [tests, setTests] = useState(mockTests);
  const [studentAnswers, setStudentAnswers] = useState(mockStudentAnswers);
  const [taskSubmissions, setTaskSubmissions] = useState(mockTaskSubmissions);

  const currentUser = mockUsers[userIndex];

  const switchRole = () => {
    setUserIndex(prev => prev === 0 ? 1 : 0);
  };

  const submitTestAnswers = (testId: string, answers: Record<string, number>): number => {
    const test = tests.find(t => t.id === testId);
    if (!test) return 0;
    let score = 0;
    test.questions.forEach(q => {
      if (answers[q.id] === q.correctChoice) score++;
    });
    const newAnswer: StudentAnswer = {
      id: `sa-${Date.now()}`,
      studentId: currentUser.id,
      studentName: currentUser.name,
      testId,
      answers,
      score,
      totalQuestions: test.questions.length,
      submittedAt: new Date().toISOString().split('T')[0],
    };
    setStudentAnswers(prev => [...prev, newAnswer]);
    return score;
  };

  const submitTask = (taskId: string, fileName: string) => {
    const newSubmission: TaskSubmission = {
      id: `ts-${Date.now()}`,
      studentId: currentUser.id,
      studentName: currentUser.name,
      taskId,
      fileName,
      submittedAt: new Date().toISOString().split('T')[0],
    };
    setTaskSubmissions(prev => [...prev, newSubmission]);
  };

  const addMaterial = (material: Omit<DidacticMaterial, 'id'>) => {
    setMaterials(prev => [...prev, { ...material, id: `mat-${Date.now()}` }]);
  };

  const addTask = (task: Omit<Task, 'id' | 'createdAt'>) => {
    setTasks(prev => [...prev, { ...task, id: `task-${Date.now()}`, createdAt: new Date().toISOString().split('T')[0] }]);
  };

  const addTest = (test: Omit<Test, 'id' | 'createdAt'>) => {
    setTests(prev => [...prev, { ...test, id: `test-${Date.now()}`, createdAt: new Date().toISOString().split('T')[0] }]);
  };

  return (
    <AppContext.Provider value={{
      currentUser, subjects, materials, tasks, tests, studentAnswers, taskSubmissions,
      switchRole, submitTestAnswers, submitTask, addMaterial, addTask, addTest,
    }}>
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const ctx = useContext(AppContext);
  if (!ctx) throw new Error('useApp must be used within AppProvider');
  return ctx;
}
