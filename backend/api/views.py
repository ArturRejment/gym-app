from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import generics
from django.http import JsonResponse
from rest_framework.views import APIView

from .Serializers.serializer import *
from .models import *

class AddressView(APIView):
    def get(self, request, *args, **kwargs):
        qs = Address.objects.all()
        serializer = AddressSerializer(qs, many=True)
        return Response(serializer.data)
    
    def post(self, request, *args, **kwargs):
        serializer = AddressSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        else:
            return Response(serializer.errors, status=422)
    
class TrainerView(APIView):
    def get(self, request, *args, **kwargs):
        qs = TrainerHours.objects.filter(trainer=self.kwargs['ident'])
        serializer = TrainerHoursSerializer(qs, many=True)
        return Response(serializer.data)
    
class ActiveHoursForTrainer(APIView):
    def get(self, request, *args, **kwargs):
        qs = TrainerHours.objects.filter(trainer=self.kwargs['ident'], is_active=True, is_taken=False)
        serializer = TrainerAvailableHoursSerializer(qs, many=True)
        return Response(serializer.data)

class ShopProductsList(APIView):
    def get(self, request, *args, **kwargs):
        qs = ShopProducts.objects.filter(shop=self.kwargs['ident'])
        serializer = ShopProductsSerializer(qs, many=True)
        return Response(serializer.data)




    
# class AvailableTrainersView(APIView):
#     def get(self, request, *args, **kwargs):
#         qs = AvailableTrainers.objects.all()
#         serializer = AvailableTrainersSerializer(qs, many=True)
#         return Response(serializer.data)