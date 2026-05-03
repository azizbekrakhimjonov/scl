import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { User, Subject, DidacticMaterial, Task, Test, StudentAnswer, TaskSubmission } from '@/types';
import { mockUsers, mockSubjects, mockMaterials, mockTasks, mockTests, mockStudentAnswers, mockTaskSubmissions } from '@/data/mockData';

const API_BASE = 'http://127.0.0.1:8005/api';

interface AppState {
  currentUser: User | null;
  subjects: Subject[];
  materials: DidacticMaterial[];
  tasks: Task[];
  tests: Test[];
  studentAnswers: StudentAnswer[];
  taskSubmissions: TaskSubmission[];
  login: (email: string, password: string) => Promise<boolean>;
  logout: () => void;
  submitTestAnswers: (testId: string, answers: Record<string, number>) => Promise<number>;
  submitTask: (taskId: string, fileName: string) => Promise<void>;
  addMaterial: (material: Omit<DidacticMaterial, 'id'>) => Promise<void>;
  addTask: (task: Omit<Task, 'id' | 'createdAt'>) => Promise<void>;
  addTest: (test: Omit<Test, 'id' | 'createdAt'>) => Promise<void>;
}

const AppContext = createContext<AppState | null>(null);

export function AppProvider({ children }: { children: ReactNode }) {
  const [currentUser, setCurrentUser] = useState<User | null>(null);
  const [users, setUsers] = useState<User[]>([]);
  const [subjects, setSubjects] = useState<Subject[]>(mockSubjects);
  const [materials, setMaterials] = useState<DidacticMaterial[]>(mockMaterials);
  const [tasks, setTasks] = useState<Task[]>(mockTasks);
  const [tests, setTests] = useState<Test[]>(mockTests);
  const [studentAnswers, setStudentAnswers] = useState<StudentAnswer[]>(mockStudentAnswers);
  const [taskSubmissions, setTaskSubmissions] = useState<TaskSubmission[]>(mockTaskSubmissions);

  const loadData = async () => {
    try {
      const responses = await Promise.all([
        fetch(`${API_BASE}/users/`),
        fetch(`${API_BASE}/subjects/`),
        fetch(`${API_BASE}/materials/`),
        fetch(`${API_BASE}/tasks/`),
        fetch(`${API_BASE}/tests/`),
        fetch(`${API_BASE}/student-answers/`),
        fetch(`${API_BASE}/task-submissions/`)
      ]);
      
      const data = await Promise.all(responses.map(res => res.ok ? res.json() : []));
      
      if (data[0].length) setUsers(data[0]); else setUsers(mockUsers);
      if (data[1].length) setSubjects(data[1]);
      if (data[2].length) setMaterials(data[2]);
      if (data[3].length) setTasks(data[3]);
      if (data[4].length) setTests(data[4]);
      if (data[5].length) setStudentAnswers(data[5]);
      if (data[6].length) setTaskSubmissions(data[6]);
    } catch (e) {
      console.warn("Backend topilmadi, mock dataga qaytilmoqda");
      setUsers(mockUsers);
    }
  };

  useEffect(() => {
    loadData();
  }, []);

  const login = async (email: string, password: string): Promise<boolean> => {
    // Check locally fetched users first, fallback to mock if empty
    const user = users.find(u => u.email === email && u.password === password) || mockUsers.find(u => u.email === email && u.password === password);
    if (user) {
      setCurrentUser(user);
      return true;
    }
    return false;
  };

  const logout = () => {
    setCurrentUser(null);
  };

  const submitTestAnswers = async (testId: string, answers: Record<string, number>): Promise<number> => {
    if (!currentUser) return 0;
    const test = tests.find(t => t.id === testId);
    if (!test) return 0;
    
    let score = 0;
    test.questions.forEach(q => {
      if (answers[q.id] === q.correctChoice) score++;
    });
    
    const newAnswer = {
      student: currentUser.id,
      test: testId,
      answers,
      score,
      total_questions: test.questions.length,
    };

    try {
      const res = await fetch(`${API_BASE}/student-answers/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newAnswer)
      });
      if (res.ok) {
        const saved = await res.json();
        setStudentAnswers(prev => [...prev, saved]);
      } else {
        throw new Error('API failure');
      }
    } catch (e) {
      setStudentAnswers(prev => [...prev, { ...newAnswer, id: `sa-${Date.now()}`, studentId: currentUser.id, studentName: currentUser.name, submittedAt: new Date().toISOString() } as unknown as StudentAnswer]);
    }
    return score;
  };

  const submitTask = async (taskId: string, fileName: string) => {
    if (!currentUser) return;
    const newSubmission = {
      student: currentUser.id,
      task: taskId,
      file_name: fileName,
    };
    
    try {
      const res = await fetch(`${API_BASE}/task-submissions/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newSubmission)
      });
      if (res.ok) {
        const saved = await res.json();
        setTaskSubmissions(prev => [...prev, saved]);
      } else {
        throw new Error('API failure');
      }
    } catch (e) {
      setTaskSubmissions(prev => [...prev, { ...newSubmission, id: `ts-${Date.now()}`, taskId, studentId: currentUser.id, studentName: currentUser.name, submittedAt: new Date().toISOString() } as unknown as TaskSubmission]);
    }
  };

  const addMaterial = async (material: Omit<DidacticMaterial, 'id'>) => {
    const apiMaterial = { ...material, subject: material.subjectId };
    try {
      const res = await fetch(`${API_BASE}/materials/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(apiMaterial)
      });
      if (res.ok) {
         const saved = await res.json();
         setMaterials(prev => [...prev, saved]);
      } else {
         throw new Error('API failure');
      }
    } catch (e) {
      setMaterials(prev => [...prev, { ...material, id: `mat-${Date.now()}` }]);
    }
  };

  const addTask = async (task: Omit<Task, 'id' | 'createdAt'>) => {
    const apiTask = { ...task, subject: task.subjectId };
    try {
      const res = await fetch(`${API_BASE}/tasks/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(apiTask)
      });
      if (res.ok) {
         const saved = await res.json();
         setTasks(prev => [...prev, saved]);
      } else {
         throw new Error('API failure');
      }
    } catch (e) {
      setTasks(prev => [...prev, { ...task, id: `task-${Date.now()}`, createdAt: new Date().toISOString() }]);
    }
  };

  const addTest = async (test: Omit<Test, 'id' | 'createdAt'>) => {
    const apiTest = { title: test.title, subject: test.subjectId };
    let savedTestId = `test-${Date.now()}`;
    
    try {
      const res = await fetch(`${API_BASE}/tests/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(apiTest)
      });
      if (res.ok) {
         const saved = await res.json();
         savedTestId = saved.id;
         setTests(prev => [...prev, { ...saved, questions: test.questions }]);
         
         // Submit questions
         for (const q of test.questions) {
            await fetch(`${API_BASE}/questions/`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ ...q, test: savedTestId })
            });
         }
      } else {
         throw new Error('API failure');
      }
    } catch (e) {
      setTests(prev => [...prev, { ...test, id: savedTestId, createdAt: new Date().toISOString() }]);
    }
  };

  return (
    <AppContext.Provider value={{
      currentUser, subjects, materials, tasks, tests, studentAnswers, taskSubmissions,
      login, logout, submitTestAnswers, submitTask, addMaterial, addTask, addTest,
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
