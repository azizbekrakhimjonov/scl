import { useParams, useNavigate, Navigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import RoleSwitcher from '@/components/RoleSwitcher';
import EmptyState from '@/components/EmptyState';
import { FileText, ClipboardList, BookCheck, ChevronRight, Plus, Download, FolderOpen } from 'lucide-react';
import { useState } from 'react';

type TabType = 'materials' | 'tests' | 'tasks';

export default function SubjectDetailPage() {
  const { subjectId } = useParams();
  const navigate = useNavigate();
  const { subjects, materials, tests, tasks, currentUser } = useApp();
  const [activeTab, setActiveTab] = useState<TabType>('materials');

  const subject = subjects.find(s => s.id === subjectId);
  const subjectMaterials = materials.filter(m => m.subjectId === subjectId);
  const subjectTests = tests.filter(t => t.subjectId === subjectId);
  const subjectTasks = tasks.filter(t => t.subjectId === subjectId);

  if (!subject) return null;

  const tabs: { key: TabType; label: string; icon: React.ReactNode }[] = [
    { key: 'materials', label: 'Materiallar', icon: <FileText className="w-4 h-4" /> },
    { key: 'tests', label: 'Testlar', icon: <ClipboardList className="w-4 h-4" /> },
    { key: 'tasks', label: 'Vazifalar', icon: <BookCheck className="w-4 h-4" /> },
  ];

  return (
    <div className="min-h-screen bg-background">
      <AppHeader title={subject.name} showBack rightAction={<RoleSwitcher />} />

      {/* Tabs */}
      <div className="flex border-b border-border">
        {tabs.map(tab => (
          <button
            key={tab.key}
            onClick={() => setActiveTab(tab.key)}
            className={`flex-1 flex items-center justify-center gap-1.5 py-3 text-sm font-medium transition-colors ${
              activeTab === tab.key
                ? 'text-primary border-b-2 border-primary'
                : 'text-muted-foreground'
            }`}
          >
            {tab.icon}
            {tab.label}
          </button>
        ))}
      </div>

      <div className="p-4 space-y-3">
        {activeTab === 'materials' && (
          <>
            {subjectMaterials.length === 0 ? (
              <EmptyState icon={<FolderOpen className="w-12 h-12" />} title="Materiallar yo'q" description="Hozircha bu fanda materiallar mavjud emas." />
            ) : (
              subjectMaterials.map((mat, i) => (
                <div key={mat.id} className="app-card animate-fade-in" style={{ animationDelay: `${i * 50}ms` }}>
                  <p className="item-title mb-1">{mat.title}</p>
                  <p className="body-text mb-3">{mat.description}</p>
                  <div className="flex items-center gap-2 text-muted-foreground">
                    <Download className="w-4 h-4" />
                    <span className="text-xs">{mat.fileName}</span>
                  </div>
                </div>
              ))
            )}
            {currentUser.role === 'teacher' && (
              <button
                onClick={() => navigate(`/subjects/${subjectId}/add-material`)}
                className="w-full h-12 flex items-center justify-center gap-2 border-2 border-dashed border-border rounded-xl text-muted-foreground font-medium text-sm active:bg-secondary transition-colors"
              >
                <Plus className="w-4 h-4" /> Material qo'shish
              </button>
            )}
          </>
        )}

        {activeTab === 'tests' && (
          <>
            {subjectTests.length === 0 ? (
              <EmptyState icon={<ClipboardList className="w-12 h-12" />} title="Testlar yo'q" description="Hozircha bu fanda testlar mavjud emas." />
            ) : (
              subjectTests.map((test, i) => (
                <div key={test.id} className="app-card flex items-center gap-3 animate-fade-in" style={{ animationDelay: `${i * 50}ms` }}>
                  <div className="flex-1">
                    <p className="item-title">{test.title}</p>
                    <p className="body-text">{test.questions.length} ta savol · {test.createdAt}</p>
                  </div>
                  {currentUser.role === 'student' && (
                    <button
                      onClick={() => navigate(`/tests/${test.id}`)}
                      className="px-4 py-2 bg-primary text-primary-foreground rounded-lg text-sm font-medium active:opacity-90 transition-opacity"
                    >
                      Boshlash
                    </button>
                  )}
                </div>
              ))
            )}
            {currentUser.role === 'teacher' && (
              <button
                onClick={() => navigate(`/subjects/${subjectId}/add-test`)}
                className="w-full h-12 flex items-center justify-center gap-2 border-2 border-dashed border-border rounded-xl text-muted-foreground font-medium text-sm active:bg-secondary transition-colors"
              >
                <Plus className="w-4 h-4" /> Test qo'shish
              </button>
            )}
          </>
        )}

        {activeTab === 'tasks' && (
          <>
            {subjectTasks.length === 0 ? (
              <EmptyState icon={<BookCheck className="w-12 h-12" />} title="Vazifalar yo'q" description="Hozircha bu fanda vazifalar mavjud emas." />
            ) : (
              subjectTasks.map((task, i) => (
                <div key={task.id} className="app-card flex items-center gap-3 animate-fade-in" style={{ animationDelay: `${i * 50}ms` }}>
                  <div className="flex-1">
                    <p className="item-title">{task.title}</p>
                    <p className="body-text">{task.description.slice(0, 60)}...</p>
                    <p className="text-xs text-muted-foreground mt-1">{task.createdAt}</p>
                  </div>
                  {currentUser.role === 'student' && (
                    <button
                      onClick={() => navigate(`/tasks/${task.id}`)}
                      className="px-4 py-2 bg-primary text-primary-foreground rounded-lg text-sm font-medium active:opacity-90 transition-opacity"
                    >
                      Topshirish
                    </button>
                  )}
                </div>
              ))
            )}
            {currentUser.role === 'teacher' && (
              <button
                onClick={() => navigate(`/subjects/${subjectId}/add-task`)}
                className="w-full h-12 flex items-center justify-center gap-2 border-2 border-dashed border-border rounded-xl text-muted-foreground font-medium text-sm active:bg-secondary transition-colors"
              >
                <Plus className="w-4 h-4" /> Vazifa qo'shish
              </button>
            )}
          </>
        )}
      </div>
    </div>
  );
}
