import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import RoleSwitcher from '@/components/RoleSwitcher';
import EmptyState from '@/components/EmptyState';
import { Users, ChevronRight } from 'lucide-react';
import { useState } from 'react';

type ResultTab = 'tests' | 'tasks';

export default function ResultsPage() {
  const { studentAnswers, taskSubmissions, tests, tasks } = useApp();
  const [tab, setTab] = useState<ResultTab>('tests');

  return (
    <div className="min-h-screen bg-background">
      <AppHeader title="Natijalar" showBack rightAction={<RoleSwitcher />} />

      <div className="flex border-b border-border">
        <button
          onClick={() => setTab('tests')}
          className={`flex-1 py-3 text-sm font-medium transition-colors ${tab === 'tests' ? 'text-primary border-b-2 border-primary' : 'text-muted-foreground'}`}
        >
          Test natijalari
        </button>
        <button
          onClick={() => setTab('tasks')}
          className={`flex-1 py-3 text-sm font-medium transition-colors ${tab === 'tasks' ? 'text-primary border-b-2 border-primary' : 'text-muted-foreground'}`}
        >
          Vazifa natijalari
        </button>
      </div>

      <div className="p-4 space-y-3">
        {tab === 'tests' && (
          <>
            {studentAnswers.length === 0 ? (
              <EmptyState icon={<Users className="w-12 h-12" />} title="Natijalar yo'q" description="Hali hech kim test topshirmagan." />
            ) : (
              studentAnswers.map((sa, i) => {
                const test = tests.find(t => t.id === sa.testId);
                return (
                  <div key={sa.id} className="app-card animate-fade-in" style={{ animationDelay: `${i * 50}ms` }}>
                    <div className="flex items-center justify-between mb-1">
                      <p className="item-title">{sa.studentName}</p>
                      <span className="text-lg font-bold text-primary" style={{ fontFeatureSettings: '"tnum"' }}>
                        {sa.score}/{sa.totalQuestions}
                      </span>
                    </div>
                    <p className="body-text">{test?.title || 'Test'} · {sa.submittedAt}</p>
                  </div>
                );
              })
            )}
          </>
        )}

        {tab === 'tasks' && (
          <>
            {taskSubmissions.length === 0 ? (
              <EmptyState icon={<Users className="w-12 h-12" />} title="Natijalar yo'q" description="Hali hech kim vazifa topshirmagan." />
            ) : (
              taskSubmissions.map((ts, i) => {
                const task = tasks.find(t => t.id === ts.taskId);
                return (
                  <div key={ts.id} className="app-card animate-fade-in" style={{ animationDelay: `${i * 50}ms` }}>
                    <div className="flex items-center justify-between mb-1">
                      <p className="item-title">{ts.studentName}</p>
                      {ts.score !== undefined && (
                        <span className="text-lg font-bold text-primary" style={{ fontFeatureSettings: '"tnum"' }}>
                          {ts.score}%
                        </span>
                      )}
                    </div>
                    <p className="body-text">{task?.title || 'Vazifa'} · {ts.submittedAt}</p>
                    <p className="text-xs text-muted-foreground mt-1">📎 {ts.fileName}</p>
                  </div>
                );
              })
            )}
          </>
        )}
      </div>
    </div>
  );
}
