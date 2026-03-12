import { useApp } from '@/context/AppContext';
import { ArrowRightLeft } from 'lucide-react';

export default function RoleSwitcher() {
  const { currentUser, switchRole } = useApp();

  return (
    <button
      onClick={switchRole}
      className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-accent text-accent-foreground text-sm font-medium transition-colors active:bg-secondary"
    >
      <ArrowRightLeft className="w-4 h-4" />
      {currentUser.role === 'teacher' ? 'O\'qituvchi' : 'O\'quvchi'}
    </button>
  );
}
