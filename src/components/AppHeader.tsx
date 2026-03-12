import { ChevronLeft } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

interface AppHeaderProps {
  title: string;
  showBack?: boolean;
  rightAction?: React.ReactNode;
}

export default function AppHeader({ title, showBack = false, rightAction }: AppHeaderProps) {
  const navigate = useNavigate();

  return (
    <header className="sticky top-0 z-10 bg-background border-b border-border px-4 py-3 flex items-center gap-3">
      {showBack && (
        <button
          onClick={() => navigate(-1)}
          className="p-1 -ml-1 rounded-lg active:bg-secondary transition-colors"
          aria-label="Orqaga"
        >
          <ChevronLeft className="w-6 h-6 text-foreground" />
        </button>
      )}
      <h1 className="screen-title flex-1 truncate">{title}</h1>
      {rightAction}
    </header>
  );
}
