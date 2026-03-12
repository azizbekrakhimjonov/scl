import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useApp } from '@/context/AppContext';
import { BookOpen, LogIn, Eye, EyeOff } from 'lucide-react';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from 'sonner';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const { login } = useApp();
  const navigate = useNavigate();

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    const success = login(email, password);
    if (success) {
      toast.success('Muvaffaqiyatli kirdingiz!');
      navigate('/subjects');
    } else {
      toast.error('Email yoki parol noto\'g\'ri');
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen px-6 bg-background">
      <div className="w-full max-w-sm animate-fade-in">
        <div className="flex flex-col items-center mb-10">
          <div className="w-16 h-16 rounded-2xl bg-primary flex items-center justify-center mb-4">
            <BookOpen className="w-8 h-8 text-primary-foreground" />
          </div>
          <h1 className="screen-title mb-1">Tizimga kirish</h1>
          <p className="body-text">Email va parol bilan kiring</p>
        </div>

        <form onSubmit={handleLogin} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="email">Email</Label>
            <Input
              id="email"
              type="email"
              placeholder="email@example.uz"
              value={email}
              onChange={e => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="password">Parol</Label>
            <div className="relative">
              <Input
                id="password"
                type={showPassword ? 'text' : 'password'}
                placeholder="Parolni kiriting"
                value={password}
                onChange={e => setPassword(e.target.value)}
                required
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground"
              >
                {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
          </div>

          <button
            type="submit"
            className="w-full h-12 bg-primary text-primary-foreground rounded-lg font-medium text-base flex items-center justify-center gap-2 active:opacity-90 transition-opacity mt-6"
          >
            <LogIn className="w-5 h-5" />
            Kirish
          </button>
        </form>

        <div className="mt-8 app-card">
          <p className="text-xs text-muted-foreground mb-3 font-medium">Demo foydalanuvchilar:</p>
          <div className="space-y-2 text-xs">
            <div className="flex justify-between text-foreground">
              <span>O'qituvchi:</span>
              <span className="font-mono text-muted-foreground">sardor@teacher.uz</span>
            </div>
            <div className="flex justify-between text-foreground">
              <span>O'quvchi:</span>
              <span className="font-mono text-muted-foreground">jasur@student.uz</span>
            </div>
            <p className="text-muted-foreground pt-1">Parol: <span className="font-mono">123456</span></p>
          </div>
        </div>
      </div>
    </div>
  );
}
