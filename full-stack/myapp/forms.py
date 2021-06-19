from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User


class CreateUserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email', 'password1', 'password2']


class CreateNewTrainer(forms.Form):
    firstname = forms.CharField(label="Name", max_length=10)
    lastname = forms.CharField(label="Name", max_length=10)
    id = forms.IntegerField(label="Id")


class UpdateWorkingHours(forms.Form):
    isActive = forms.BooleanField()
