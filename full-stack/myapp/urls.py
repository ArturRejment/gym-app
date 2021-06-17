from django.urls import path
from . import views

urlpatterns = [
    path("client/<int:id>", views.client, name="client"),
    path("trainerUpdate", views.trainerUpdate, name="trainerUpdate"),
    path("receptionist/<int:id>", views.receptionist, name="receptionist"),
    path("", views.index, name="index"),
    path("trainerPage/", views.trainerPage, name="trainerPage"),
    path("login/", views.loginPage, name="login"),
    path("logout/", views.logoutPage, name="logout"),
]
