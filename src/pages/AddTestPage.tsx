import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import { Plus, Trash2 } from 'lucide-react';
import { toast } from 'sonner';
import { Question } from '@/types';

export default function AddTestPage() {
  const { subjectId } = useParams();
  const navigate = useNavigate();
  const { addTest } = useApp();
  const [title, setTitle] = useState('');
  const [questions, setQuestions] = useState<Omit<Question, 'id'>[]>([
    { questionText: '', choices: ['', '', '', ''], correctChoice: 0 },
  ]);

  const addQuestion = () => {
    setQuestions(prev => [...prev, { questionText: '', choices: ['', '', '', ''], correctChoice: 0 }]);
  };

  const removeQuestion = (idx: number) => {
    if (questions.length <= 1) return;
    setQuestions(prev => prev.filter((_, i) => i !== idx));
  };

  const updateQuestion = (idx: number, field: string, value: string) => {
    setQuestions(prev => prev.map((q, i) => i === idx ? { ...q, [field]: value } : q));
  };

  const updateChoice = (qIdx: number, cIdx: number, value: string) => {
    setQuestions(prev => prev.map((q, i) => {
      if (i !== qIdx) return q;
      const choices = [...q.choices];
      choices[cIdx] = value;
      return { ...q, choices };
    }));
  };

  const setCorrect = (qIdx: number, cIdx: number) => {
    setQuestions(prev => prev.map((q, i) => i === qIdx ? { ...q, correctChoice: cIdx } : q));
  };

  const handleSave = () => {
    if (!title.trim()) { toast.error('Test nomini kiriting'); return; }
    for (const q of questions) {
      if (!q.questionText.trim()) { toast.error('Barcha savollarni yozing'); return; }
      if (q.choices.some(c => !c.trim())) { toast.error('Barcha variantlarni to\'ldiring'); return; }
    }
    addTest({
      title,
      subjectId: subjectId!,
      questions: questions.map((q, i) => ({ ...q, id: `new-q-${i}` })),
    });
    toast.success("Test qo'shildi!");
    navigate(-1);
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      <AppHeader title="Test qo'shish" showBack />
      <div className="p-4 space-y-4">
        <div className="space-y-2">
          <label className="text-sm font-medium text-foreground">Test nomi</label>
          <input type="text" value={title} onChange={e => setTitle(e.target.value)} placeholder="Test sarlavhasi" className="w-full h-12 px-4 bg-input rounded-lg text-base text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
        </div>

        {questions.map((q, qIdx) => (
          <div key={qIdx} className="app-card space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-sm font-medium text-muted-foreground">Savol {qIdx + 1}</span>
              {questions.length > 1 && (
                <button onClick={() => removeQuestion(qIdx)} className="p-1 text-destructive">
                  <Trash2 className="w-4 h-4" />
                </button>
              )}
            </div>
            <input type="text" value={q.questionText} onChange={e => updateQuestion(qIdx, 'questionText', e.target.value)} placeholder="Savol matni" className="w-full h-10 px-3 bg-input rounded-lg text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
            {q.choices.map((c, cIdx) => (
              <div key={cIdx} className="flex items-center gap-2">
                <button
                  onClick={() => setCorrect(qIdx, cIdx)}
                  className={`w-6 h-6 rounded-full border-2 flex items-center justify-center shrink-0 transition-colors ${
                    q.correctChoice === cIdx ? 'border-primary bg-primary' : 'border-border'
                  }`}
                >
                  {q.correctChoice === cIdx && <div className="w-2 h-2 rounded-full bg-primary-foreground" />}
                </button>
                <input type="text" value={c} onChange={e => updateChoice(qIdx, cIdx, e.target.value)} placeholder={`${String.fromCharCode(65 + cIdx)} variant`} className="flex-1 h-10 px-3 bg-input rounded-lg text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
              </div>
            ))}
          </div>
        ))}

        <button onClick={addQuestion} className="w-full h-12 flex items-center justify-center gap-2 border-2 border-dashed border-border rounded-xl text-muted-foreground font-medium text-sm active:bg-secondary transition-colors">
          <Plus className="w-4 h-4" /> Savol qo'shish
        </button>
      </div>

      <div className="fixed bottom-0 left-0 right-0 p-4 bg-background border-t border-border">
        <button onClick={handleSave} className="w-full h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base active:opacity-90 transition-opacity">
          Saqlash
        </button>
      </div>
    </div>
  );
}
