from django import forms


class CreateNewTrainer(forms.Form):
    firstname = forms.CharField(label="Name", max_length=10)
    lastname = forms.CharField(label="Name", max_length=10)
    id = forms.IntegerField(label="Id")


class UpdateWorkingHours(forms.Form):
    isActive = forms.BooleanField()
