import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import { toast } from 'sonner';

export default function AddTaskPage() {
  const { subjectId } = useParams();
  const navigate = useNavigate();
  const { addTask } = useApp();
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');

  const handleSave = () => {
    if (!title.trim() || !description.trim()) {
      toast.error("Barcha maydonlarni to'ldiring");
      return;
    }
    addTask({ title, description, subjectId: subjectId! });
    toast.success("Vazifa qo'shildi!");
    navigate(-1);
  };

  return (
    <div className="min-h-screen bg-background">
      <AppHeader title="Vazifa qo'shish" showBack />
      <div className="p-4 space-y-4">
        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Sarlavha</label>
          <input type="text" value={title} onChange={e => setTitle(e.target.value)} placeholder="Vazifa nomi" className="w-full h-12 px-4 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
        </div>
        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Tavsif</label>
          <textarea value={description} onChange={e => setDescription(e.target.value)} placeholder="Vazifa haqida batafsil" rows={4} className="w-full px-4 py-3 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring resize-none" />
        </div>
        <button onClick={handleSave} className="w-full h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base active:opacity-90 transition-opacity">
          Saqlash
        </button>
      </div>
    </div>
  );
}
