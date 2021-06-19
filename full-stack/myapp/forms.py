from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Address


class CreateUserForm(UserCreationForm):
    phone = forms.CharField()
    postcode = forms.CharField()
    city = forms.CharField()
    street = forms.CharField()
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email', 'password1', 'password2', 'postcode', 'city', 'street', 'phone']

    def save(self, commit=True):
        user = super(CreateUserForm, self).save(commit=False)
        user._street = 'hello'
        user._city = 'city'
        user._phone = 'phone'
        user._postcode = 'post'

        if commit:
            user.save()

        return user


class AddressForm(forms.Form):

    class Meta:
        model = Address
        fields = '__all__'

