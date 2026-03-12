import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { AppProvider } from "@/context/AppContext";
import WelcomePage from "./pages/WelcomePage";
import SubjectsPage from "./pages/SubjectsPage";
import SubjectDetailPage from "./pages/SubjectDetailPage";
import TestTakingPage from "./pages/TestTakingPage";
import TaskSubmitPage from "./pages/TaskSubmitPage";
import ResultsPage from "./pages/ResultsPage";
import AddMaterialPage from "./pages/AddMaterialPage";
import AddTaskPage from "./pages/AddTaskPage";
import AddTestPage from "./pages/AddTestPage";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Sonner />
      <AppProvider>
        <BrowserRouter>
          <div className="max-w-md mx-auto min-h-screen bg-background">
            <Routes>
              <Route path="/" element={<WelcomePage />} />
              <Route path="/subjects" element={<SubjectsPage />} />
              <Route path="/subjects/:subjectId" element={<SubjectDetailPage />} />
              <Route path="/subjects/:subjectId/add-material" element={<AddMaterialPage />} />
              <Route path="/subjects/:subjectId/add-task" element={<AddTaskPage />} />
              <Route path="/subjects/:subjectId/add-test" element={<AddTestPage />} />
              <Route path="/tests/:testId" element={<TestTakingPage />} />
              <Route path="/tasks/:taskId" element={<TaskSubmitPage />} />
              <Route path="/results" element={<ResultsPage />} />
              <Route path="*" element={<NotFound />} />
            </Routes>
          </div>
        </BrowserRouter>
      </AppProvider>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
