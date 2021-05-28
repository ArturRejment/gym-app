from rest_framework import serializers
from api.models import *

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ('__all__')
        
        
class AddressCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ('postcode', 'city', 'street')
    def create(self, validated_data):
        validated_data['address_id'] = Address.objects.last().address_id+1
        return Address.objects.create(**validated_data)
        
class TrainerHoursSerializer(serializers.ModelSerializer):
    working_start = serializers.CharField(source='working.start_time', read_only=True)
    working_finish = serializers.CharField(source='working.finish_time', read_only=True)
    member_id = serializers.FloatField(source='member.member_id', allow_null=True)
    shift_id = serializers.ReadOnlyField()
    
    class Meta:
        model = TrainerHours
        fields = ('shift_id', 'working_start', 'working_finish', 'is_active',  'member_id')
       
    def update(self, instance, validated_data):
        instance.is_active = validated_data.get('is_active', instance.is_active)
        instance.is_taken = validated_data.get('is_taken', instance.is_taken)
        ident = validated_data.get('member', instance.member)
        
        if ident["member_id"] != None:
            instance.member = GymMember.objects.get(member_id = ident['member_id'])
        else:
            instance.member = None
        
        instance.save()
        return instance
       
        
class TrainerAvailableHoursSerializer(serializers.ModelSerializer):
    working_start = serializers.CharField(source='working.start_time')
    working_finish = serializers.CharField(source='working.finish_time')
    class Meta:
        model = TrainerHours
        fields = ('shift_id', 'working_start', 'working_finish')

class ShopProductsSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source='product.product_name')
    price = serializers.FloatField(source='product.product_price')

    class Meta:
        model = ShopProducts
        fields = ('product_name', 'price')
    

# class AvailableTrainersSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = AvailableTrainers
#         fields = ('__all__')