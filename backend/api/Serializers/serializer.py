from rest_framework import serializers
from api.models import *

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ('address_id', 'postcode', 'city', 'street')
        
class TrainerHoursSerializer(serializers.ModelSerializer):
    working_start = serializers.CharField(source='working.start_time')
    working_finish = serializers.CharField(source='working.finish_time')
    member_name = serializers.CharField(source='member.first_name', allow_null=True)
    
    class Meta:
        model = TrainerHours
        fields = ('working_start', 'working_finish', 'is_active', 'is_taken', 'member_name')
        
class TrainerAvailableHoursSerializer(serializers.ModelSerializer):
    working_start = serializers.CharField(source='working.start_time')
    working_finish = serializers.CharField(source='working.finish_time')
    class Meta:
        model = TrainerHours
        fields = ('working_start', 'working_finish')

class ShopProductsSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source='product.product_name')
    price = serializers.FloatField(source='product.price')

    class Meta:
        model = ShopProducts
        fields = ('product_name', 'price')
    

# class AvailableTrainersSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = AvailableTrainers
#         fields = ('__all__')