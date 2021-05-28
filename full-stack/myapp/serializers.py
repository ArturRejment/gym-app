from rest_framework import serializers
from .models import *


class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ('__all__')


class TrainerHoursSerializer(serializers.ModelSerializer):
    class Meta:
        model = TrainerHours
        fields = ('__all__')


class TrainerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Trainer
        fields = ('__all___')
