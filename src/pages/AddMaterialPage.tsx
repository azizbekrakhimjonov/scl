import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import { toast } from 'sonner';

export default function AddMaterialPage() {
  const { subjectId } = useParams();
  const navigate = useNavigate();
  const { addMaterial } = useApp();
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [fileName, setFileName] = useState('');

  const handleSave = () => {
    if (!title.trim() || !description.trim()) {
      toast.error('Barcha maydonlarni to\'ldiring');
      return;
    }
    addMaterial({ title, description, fileName: fileName || 'material.pdf', subjectId: subjectId! });
    toast.success('Material qo\'shildi!');
    navigate(-1);
  };

  return (
    <div className="min-h-screen bg-background">
      <AppHeader title="Material qo'shish" showBack />
      <div className="p-4 space-y-4">
        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Sarlavha</label>
          <input type="text" value={title} onChange={e => setTitle(e.target.value)} placeholder="Material nomi" className="w-full h-12 px-4 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
        </div>
        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Tavsif</label>
          <textarea value={description} onChange={e => setDescription(e.target.value)} placeholder="Qisqacha tavsif" rows={3} className="w-full px-4 py-3 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring resize-none" />
        </div>
        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Fayl nomi</label>
          <input type="text" value={fileName} onChange={e => setFileName(e.target.value)} placeholder="fayl.pdf" className="w-full h-12 px-4 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
        </div>
        <button onClick={handleSave} className="w-full h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base active:opacity-90 transition-opacity">
          Saqlash
        </button>
      </div>
    </div>
  );
}
