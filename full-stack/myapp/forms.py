from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Address


class CreateUserForm(UserCreationForm):
    postcode = forms.CharField()
    city = forms.CharField()
    street = forms.CharField()
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email', 'password1', 'password2', 'postcode', 'city', 'street']


class AddressForm(forms.Form):

    class Meta:
        model = Address
        fields = '__all__'

