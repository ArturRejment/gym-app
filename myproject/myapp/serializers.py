from rest_framework import serializers
from .models import *

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ('address_id', 'postcode', 'city', 'street')
        
class GymMemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = GymMember
        fields = ('member_id', 'first_name',
                  'last_name', 'address', 'phone_number', 'email')
        
class GropTrainingSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupTraining
        fields = ('group_training_id', 'group_training_name',
                  'trainer', 'working')
        
class MembershipSerializer(serializers.ModelSerializer):
    class Meta:
        model = Membership
        fields = ('membership_id', 'purchase_date',
                  'expiry_date', 'member')
        

class ProductsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Products
        fields = ('product_id', 'price',
                  'product_name')
        

class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = ('shop_id', 'shop_name',
                  'address')
        

class ShopProductsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShopProducts
        fields = ('listing_id', 'shop',
                  'product')
        
class TrainerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Trainer
        fields = ('trainer_id', 'first_name',
                  'last_name', 'address', 'phone_number', 'email')

class TrainerHoursSerializer(serializers.ModelSerializer):
    class Meta:
        model = TrainerHours
        fields = ('shift_id', 'trainer',
                  'working', 'member', 'is_active', 'is_taken')


class WorkingHoursSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkingHours
        fields = ('working_id', 'start_time',
                  'finish_time')
