from django.urls import path 
from . import views

urlpatterns = [
    path("Address", views.AddressView.as_view()),
    path("Trainer<int:ident>", views.TrainerView.as_view()),
    path("AvailableHoursTrainer<int:ident>", views.ActiveHoursForTrainer.as_view()),
    path("ShopProducts<int:ident>", views.ShopProductsList.as_view())
    
    # path('Available', views.AvailableTrainersView.as_view())
]
