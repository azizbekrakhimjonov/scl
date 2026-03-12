interface EmptyStateProps {
  icon: React.ReactNode;
  title: string;
  description: string;
}

export default function EmptyState({ icon, title, description }: EmptyStateProps) {
  return (
    <div className="flex flex-col items-center justify-center py-16 px-4">
      <div className="text-muted-foreground mb-4">{icon}</div>
      <p className="item-title mb-1">{title}</p>
      <p className="body-text text-center max-w-xs">{description}</p>
    </div>
  );
}
