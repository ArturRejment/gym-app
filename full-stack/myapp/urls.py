from django.urls import path
from . import views

urlpatterns = [
    path("client<int:id>", views.client, name="client"),
    path("trainer<int:id>", views.trainer, name="trainer"),
    path("receptionist<int:id>", views.receptionist, name="receptionist"),
    path("", views.index, name="index")
]
