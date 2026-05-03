from rest_framework import viewsets
from .models import User, Subject, DidacticMaterial, Task, Test, Question, StudentAnswer, TaskSubmission
from .serializers import UserSerializer, SubjectSerializer, DidacticMaterialSerializer, TaskSerializer, TestSerializer, QuestionSerializer, StudentAnswerSerializer, TaskSubmissionSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class SubjectViewSet(viewsets.ModelViewSet):
    queryset = Subject.objects.all()
    serializer_class = SubjectSerializer

class DidacticMaterialViewSet(viewsets.ModelViewSet):
    queryset = DidacticMaterial.objects.all()
    serializer_class = DidacticMaterialSerializer

class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer

class TestViewSet(viewsets.ModelViewSet):
    queryset = Test.objects.all()
    serializer_class = TestSerializer

class QuestionViewSet(viewsets.ModelViewSet):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializer

class StudentAnswerViewSet(viewsets.ModelViewSet):
    queryset = StudentAnswer.objects.all()
    serializer_class = StudentAnswerSerializer

class TaskSubmissionViewSet(viewsets.ModelViewSet):
    queryset = TaskSubmission.objects.all()
    serializer_class = TaskSubmissionSerializer
