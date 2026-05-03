from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    UserViewSet, SubjectViewSet, DidacticMaterialViewSet, 
    TaskViewSet, TestViewSet, QuestionViewSet, 
    StudentAnswerViewSet, TaskSubmissionViewSet
)

router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'subjects', SubjectViewSet)
router.register(r'materials', DidacticMaterialViewSet)
router.register(r'tasks', TaskViewSet)
router.register(r'tests', TestViewSet)
router.register(r'questions', QuestionViewSet)
router.register(r'student-answers', StudentAnswerViewSet)
router.register(r'task-submissions', TaskSubmissionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
