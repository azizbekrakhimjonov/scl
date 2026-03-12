import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import AppHeader from '@/components/AppHeader';
import { CheckCircle } from 'lucide-react';
import { toast } from 'sonner';

export default function TestTakingPage() {
  const { testId } = useParams();
  const navigate = useNavigate();
  const { tests, submitTestAnswers } = useApp();
  const [answers, setAnswers] = useState<Record<string, number>>({});
  const [currentQ, setCurrentQ] = useState(0);
  const [submitted, setSubmitted] = useState(false);
  const [score, setScore] = useState(0);

  const test = tests.find(t => t.id === testId);
  if (!test) return null;

  const question = test.questions[currentQ];
  const totalQ = test.questions.length;
  const allAnswered = Object.keys(answers).length === totalQ;

  const handleSelect = (choiceIndex: number) => {
    if (submitted) return;
    setAnswers(prev => ({ ...prev, [question.id]: choiceIndex }));
  };

  const handleSubmit = () => {
    const result = submitTestAnswers(test.id, answers);
    setScore(result);
    setSubmitted(true);
    toast.success('Test muvaffaqiyatli topshirildi!');
  };

  if (submitted) {
    return (
      <div className="min-h-screen bg-background">
        <AppHeader title="Natija" showBack />
        <div className="flex flex-col items-center justify-center py-20 px-6 animate-fade-in">
          <div className="w-20 h-20 rounded-full bg-accent flex items-center justify-center mb-6">
            <CheckCircle className="w-10 h-10 text-primary" />
          </div>
          <h2 className="screen-title mb-2">Test yakunlandi</h2>
          <p className="text-4xl font-bold text-primary mb-1" style={{ fontFeatureSettings: '"tnum"' }}>
            {score}/{totalQ}
          </p>
          <p className="body-text mb-8">
            {Math.round((score / totalQ) * 100)}% to'g'ri javob
          </p>
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
      <AppHeader title={test.title} showBack />

      {/* Progress */}
      <div className="px-4 pt-4">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm font-medium text-muted-foreground">
            Savol {currentQ + 1}/{totalQ}
          </span>
          <span className="text-sm font-medium text-muted-foreground" style={{ fontFeatureSettings: '"tnum"' }}>
            {Object.keys(answers).length} ta javob
          </span>
        </div>
        <div className="w-full h-1.5 bg-secondary rounded-full overflow-hidden">
          <div
            className="h-full bg-primary rounded-full transition-all duration-300"
            style={{ width: `${((currentQ + 1) / totalQ) * 100}%` }}
          />
        </div>
      </div>

      {/* Question */}
      <div className="p-4 animate-fade-in" key={currentQ}>
        <div className="app-card mb-4">
          <p className="item-title leading-relaxed">{question.questionText}</p>
        </div>

        <div className="space-y-2">
          {question.choices.map((choice, i) => (
            <button
              key={i}
              onClick={() => handleSelect(i)}
              className={`w-full p-4 rounded-xl text-left text-sm font-medium transition-all ${
                answers[question.id] === i
                  ? 'bg-primary text-primary-foreground'
                  : 'bg-card text-foreground active:bg-secondary'
              }`}
              style={{ boxShadow: answers[question.id] === i ? undefined : 'var(--shadow-card)' }}
            >
              <span className="inline-flex items-center justify-center w-6 h-6 rounded-full mr-3 text-xs font-semibold bg-secondary text-secondary-foreground" style={answers[question.id] === i ? { background: 'hsla(0,0%,100%,0.2)', color: 'inherit' } : {}}>
                {String.fromCharCode(65 + i)}
              </span>
              {choice}
            </button>
          ))}
        </div>
      </div>

      {/* Navigation */}
      <div className="fixed bottom-0 left-0 right-0 p-4 bg-background border-t border-border flex gap-3">
        <button
          onClick={() => setCurrentQ(prev => Math.max(0, prev - 1))}
          disabled={currentQ === 0}
          className="flex-1 h-12 rounded-lg font-medium text-sm bg-secondary text-secondary-foreground disabled:opacity-40 active:opacity-80 transition-opacity"
        >
          Oldingi
        </button>
        {currentQ < totalQ - 1 ? (
          <button
            onClick={() => setCurrentQ(prev => prev + 1)}
            className="flex-1 h-12 rounded-lg font-medium text-sm bg-primary text-primary-foreground active:opacity-90 transition-opacity"
          >
            Keyingi
          </button>
        ) : (
          <button
            onClick={handleSubmit}
            disabled={!allAnswered}
            className="flex-1 h-12 rounded-lg font-medium text-sm bg-primary text-primary-foreground disabled:opacity-40 active:opacity-90 transition-opacity"
          >
            Topshirish
          </button>
        )}
      </div>
    </div>
  );
}
