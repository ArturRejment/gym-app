from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="index"),

    path("trainerPage/", views.trainerPage, name="trainerPage"),
    path("trainerUpdate/", views.trainerUpdate, name="trainerUpdate"),
    path("client/", views.client, name="client"),
    path("receptionist/", views.receptionist, name="receptionist"),
    path("buyProduct/<int:id>/", views.buyProduct, name="buyProduct"),

    path("login/", views.loginPage, name="login"),
    path("register/", views.registerPage, name="register"),
    path("logout/", views.logoutPage, name="logout"),
]
