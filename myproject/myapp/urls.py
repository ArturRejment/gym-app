from django.urls import path
from . import views

urlpatterns = [
    path("Address", views.AddressView.as_view()),
    path("Address<pk>", views.AddressDetailView.as_view()),
    path("GymMember", views.GymMemberView.as_view()),
    path("GropTraining", views.GropTrainingView.as_view()),
    path("Membership", views.MembershipView.as_view()),
    path("Products", views.ProductsView.as_view()),
    path("Shop", views.ShopView.as_view()),
    path("ShopProducts", views.ShopProductsView.as_view()),
    path("Trainer", views.TrainerView.as_view()),
    path("TrainerHours", views.TrainerHoursView.as_view()),
    path("WorkingHours", views.WorkingHoursView.as_view()),
    path("add/", views.add, name="add"),
    path("client<int:id>", views.client, name="client"),
    path("trainer<int:id>", views.trainer, name="trainer")
]
