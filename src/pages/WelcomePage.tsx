import { useNavigate } from 'react-router-dom';
import { BookOpen } from 'lucide-react';

export default function WelcomePage() {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col items-center justify-center min-h-screen px-6 bg-background">
      <div className="animate-fade-in flex flex-col items-center text-center">
        <div className="w-20 h-20 rounded-2xl bg-primary flex items-center justify-center mb-8">
          <BookOpen className="w-10 h-10 text-primary-foreground" />
        </div>
        <h1 className="screen-title mb-2">Xush kelibsiz</h1>
        <p className="body-text mb-10 max-w-xs">
          O'qish va o'rgatish uchun ishonchli yordamchingiz
        </p>
        <button
          onClick={() => navigate('/subjects')}
          className="w-full max-w-xs h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base active:opacity-90 transition-opacity"
        >
          Boshlash
        </button>
      </div>
    </div>
  );
}
