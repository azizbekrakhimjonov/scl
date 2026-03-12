import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import { Upload, CheckCircle } from 'lucide-react';
import { toast } from 'sonner';

export default function TaskSubmitPage() {
  const { taskId } = useParams();
  const navigate = useNavigate();
  const { tasks, submitTask } = useApp();
  const [fileName, setFileName] = useState('');
  const [submitted, setSubmitted] = useState(false);

  const task = tasks.find(t => t.id === taskId);
  if (!task) return null;

  const handleSubmit = () => {
    if (!fileName.trim()) {
      toast.error('Iltimos, fayl nomini kiriting');
      return;
    }
    submitTask(task.id, fileName);
    setSubmitted(true);
    toast.success('Vazifa muvaffaqiyatli topshirildi!');
  };

  if (submitted) {
    return (
      <div className="min-h-screen bg-background">
        <AppHeader title="Topshirildi" showBack />
        <div className="flex flex-col items-center justify-center py-20 px-6 animate-fade-in">
          <div className="w-20 h-20 rounded-full bg-accent flex items-center justify-center mb-6">
            <CheckCircle className="w-10 h-10 text-primary" />
          </div>
          <h2 className="screen-title mb-2">Vazifa topshirildi</h2>
          <p className="body-text mb-8">Javobingiz qabul qilindi</p>
          <button
            onClick={() => navigate(-1)}
            className="w-full max-w-xs h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base active:opacity-90 transition-opacity"
          >
            Orqaga qaytish
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <AppHeader title="Vazifani topshirish" showBack />
      <div className="p-4 space-y-4">
        <div className="app-card">
          <p className="item-title mb-2">{task.title}</p>
          <p className="body-text">{task.description}</p>
          {task.fileName && (
            <p className="text-xs text-muted-foreground mt-2">📎 {task.fileName}</p>
          )}
        </div>

        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Javob fayli</label>
          <div className="relative">
            <input
              type="text"
              value={fileName}
              onChange={e => setFileName(e.target.value)}
              placeholder="Fayl nomini kiriting (masalan: javob.pdf)"
              className="w-full h-12 px-4 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring"
            />
          </div>
          <div className="flex items-center gap-2 p-4 border-2 border-dashed border-border rounded-xl text-muted-foreground">
            <Upload className="w-5 h-5" />
            <span className="text-sm">Faylni tanlash (demo rejim)</span>
          </div>
        </div>

        <button
          onClick={handleSubmit}
          className="w-full h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base active:opacity-90 transition-opacity"
        >
          Topshirish
        </button>
      </div>
    </div>
  );
}
