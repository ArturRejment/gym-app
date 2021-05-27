from django.urls import path 
from api.Views import views

urlpatterns = [
    path("", views.apiOverview),
    path("address", views.getAddresses),
    path("address-details/<int:ident>", views.getAddressDetail),
    path("create-address", views.createAddress),
    path("delete-address/<int:ident>", views.deleteAddress),
    path("trainer/<int:ident>", views.getTrainer),
    path("available-hours-trainer/<int:ident>", views.getActiveHoursForTrainer),
    path("shop-products/<int:ident>", views.getShopProducts),
    path("update-hour/<int:ident>", views.updateHours)
    
    # path('Available', views.AvailableTrainersView.as_view())
]
