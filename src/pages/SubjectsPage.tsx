import { useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import RoleSwitcher from '@/components/RoleSwitcher';
import { ChevronRight, BookOpen } from 'lucide-react';

export default function SubjectsPage() {
  const { subjects, currentUser } = useApp();
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-background">
      <AppHeader title="Fanlar" rightAction={<RoleSwitcher />} />
      <div className="p-4 space-y-3">
        <p className="body-text mb-2">
          {currentUser.role === 'teacher' ? 'Salom, o\'qituvchi!' : 'Salom, o\'quvchi!'} — {currentUser.name}
        </p>
        {subjects.map((subject, i) => (
          <button
            key={subject.id}
            onClick={() => navigate(`/subjects/${subject.id}`)}
            className="app-card w-full flex items-center gap-4 active:bg-secondary/50 transition-colors animate-fade-in"
            style={{ animationDelay: `${i * 50}ms` }}
          >
            <div className="w-10 h-10 rounded-lg bg-accent flex items-center justify-center shrink-0">
              <BookOpen className="w-5 h-5 text-accent-foreground" />
            </div>
            <span className="item-title flex-1 text-left">{subject.name}</span>
            <ChevronRight className="w-5 h-5 text-muted-foreground" />
          </button>
        ))}
      </div>

      {currentUser.role === 'teacher' && (
        <div className="fixed bottom-6 right-6">
          <button
            onClick={() => navigate('/results')}
            className="h-12 px-5 bg-primary text-primary-foreground rounded-full font-medium text-sm shadow-lg active:opacity-90 transition-opacity"
          >
            Natijalar
          </button>
        </div>
      )}
    </div>
  );
}
