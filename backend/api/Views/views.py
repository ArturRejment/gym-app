from django.shortcuts import render
from rest_framework.response import Response
from django.http import JsonResponse
from rest_framework.decorators import api_view

from ..Serializers.serializer import *
from ..models import *

@api_view(['GET'])
def apiOverview(request):
    api_urls = {
        'Get all addresses' : '/address',
        'Get details about address' : 'address-details/<int:ident>',
        'Create new address' : '/create-address',
        'Delete address' : '/delete-address/<int:ident>',
        'Get info about trainer' : '/trainer/<int:ident>',
        'Get available hours for trainer' : '/available-hours-trainer/<int:ident>',
        'Update particular working hour' : '/update-hour/<int:ident>',
        'Get all products in particular shop' : '/shop-products/<int:ident>'
    }
    return Response(api_urls)

#!--------------------------
#!          ADDRESS
#!--------------------------

@api_view(['GET'])
def getAddresses(request, *args, **kwargs):
    qs = Address.objects.all().order_by('address_id')
    serializer = AddressSerializer(qs, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getAddressDetail(request, ident):
    qs = Address.objects.get(address_id = ident)
    serializer = AddressSerializer(qs)
    return Response(serializer.data)

@api_view(['POST'])
def createAddress(request):
    serializer = AddressCreateSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(AddressSerializer(Address.objects.last()).data)
    else:
        return Response(serializer.errors, status=422)

@api_view(['DELETE'])
def deleteAddress(request, ident):
    try:
        addr = Address.objects.get(address_id = ident)
        addr.delete()
        return Response("Deleted with success")
    except Exception:
        return Response("No such address")
    

#!--------------------------
#!         HOURS
#!--------------------------
@api_view(['POST'])
def updateHours(request, ident):
    hour = TrainerHours.objects.get(shift_id=ident)
    serializer = TrainerHoursSerializer(instance=hour, data=request.data)
    
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    else:
        return Response(serializer.errors, status=422)
    
#!--------------------------
#!        TRAINER
#!--------------------------
@api_view(['GET'])
def getTrainer(request, ident, *args, **kwargs):
    qs = TrainerHours.objects.filter(trainer=ident)
    serializer = TrainerHoursSerializer(qs, many=True)
    return Response(serializer.data)
    
@api_view(['GET'])
def getActiveHoursForTrainer(request, ident, *args, **kwargs):
    qs = TrainerHours.objects.filter(trainer=ident, is_active=True, member=None)
    serializer = TrainerAvailableHoursSerializer(qs, many=True)
    return Response(serializer.data)


#!--------------------------
#!          SHOP
#!--------------------------
@api_view(['GET'])
def getShopProducts(request, ident, *args, **kwargs):
    qs = ShopProducts.objects.filter(shop=ident)
    serializer = ShopProductsSerializer(qs, many=True)
    return Response(serializer.data)




    
# class AvailableTrainersView(APIView):
#     def get(self, request, *args, **kwargs):
#         qs = AvailableTrainers.objects.all()
#         serializer = AvailableTrainersSerializer(qs, many=True)
#         return Response(serializer.data)