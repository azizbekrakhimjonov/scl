import { useApp } from '@/context/AppContext';
import { LogOut } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

export default function RoleSwitcher() {
  const { currentUser, logout } = useApp();
  const navigate = useNavigate();

  if (!currentUser) return null;

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  return (
    <button
      onClick={handleLogout}
      className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-accent text-accent-foreground text-sm font-medium transition-colors active:bg-secondary"
    >
      <LogOut className="w-4 h-4" />
      Chiqish
    </button>
  );
}
