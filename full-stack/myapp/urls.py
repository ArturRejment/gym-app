from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="index"),

    path("trainerPage/", views.trainerPage, name="trainerPage"),
    path("trainerUpdate/", views.trainerUpdate, name="trainerUpdate"),
    path("client/", views.client, name="client"),
    path("receptionist/", views.receptionist, name="receptionist"),

    path("login/", views.loginPage, name="login"),
    path("logout/", views.logoutPage, name="logout"),
]
