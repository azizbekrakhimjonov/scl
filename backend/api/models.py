from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    ROLE_CHOICES = (
        ('teacher', 'Teacher'),
        ('student', 'Student'),
    )
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='student')

class Subject(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class DidacticMaterial(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    file_name = models.CharField(max_length=200, blank=True, null=True)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE, related_name='materials')

    def __str__(self):
        return self.title

class Task(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    file_name = models.CharField(max_length=200, blank=True, null=True)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE, related_name='tasks')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class Test(models.Model):
    title = models.CharField(max_length=200)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE, related_name='tests')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class Question(models.Model):
    test = models.ForeignKey(Test, on_delete=models.CASCADE, related_name='questions')
    question_text = models.CharField(max_length=500)
    choices = models.JSONField(default=list)  # list of strings
    correct_choice = models.IntegerField()    # index

    def __str__(self):
        return self.question_text[:50]

class StudentAnswer(models.Model):
    student = models.ForeignKey(User, on_delete=models.CASCADE, related_name='test_answers')
    test = models.ForeignKey(Test, on_delete=models.CASCADE, related_name='answers')
    answers = models.JSONField(default=dict)  # question_id_str -> choiceIndex
    score = models.IntegerField(default=0)
    total_questions = models.IntegerField(default=0)
    submitted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.student.username} - {self.test.title}"

class TaskSubmission(models.Model):
    student = models.ForeignKey(User, on_delete=models.CASCADE, related_name='task_submissions')
    task = models.ForeignKey(Task, on_delete=models.CASCADE, related_name='submissions')
    file_name = models.CharField(max_length=200)
    score = models.IntegerField(null=True, blank=True)
    submitted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.student.username} - {self.task.title}"
