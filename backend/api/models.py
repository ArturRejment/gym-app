from django.db import models

# Create your models here.


class Address(models.Model):
    address_id = models.FloatField(primary_key=True)
    postcode = models.CharField(max_length=20, blank=True, null=True)
    city = models.CharField(max_length=20, blank=True, null=True)
    street = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'address'


class GroupTraining(models.Model):
    group_training_id = models.FloatField(primary_key=True)
    group_training_name = models.CharField(
        max_length=30, blank=True, null=True)
    trainer = models.ForeignKey('Trainer', models.DO_NOTHING)
    working = models.ForeignKey('WorkingHours', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'group_training'


class GroupTrainingSchedule(models.Model):
    group_training_schedule_id = models.FloatField(primary_key=True)
    group_training = models.ForeignKey(GroupTraining, models.DO_NOTHING)
    gym_member = models.ForeignKey('GymMember', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'group_training_schedule'


class GymMember(models.Model):
    member_id = models.FloatField(primary_key=True)
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    address = models.ForeignKey(
        Address, models.DO_NOTHING, blank=True, null=True)
    phone_number = models.CharField(max_length=9, blank=True, null=True)
    email = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'gym_member'


class Membership(models.Model):
    membership_id = models.FloatField(primary_key=True)
    purchase_date = models.DateField()
    expiry_date = models.DateField()
    member = models.ForeignKey(GymMember, models.DO_NOTHING)
    type = models.CharField(max_length=15)

    class Meta:
        managed = False
        db_table = 'membership'


class Products(models.Model):
    product_id = models.FloatField(primary_key=True)
    price = models.FloatField()
    product_name = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'products'


class Shop(models.Model):
    shop_id = models.FloatField(primary_key=True)
    shop_name = models.CharField(max_length=20)
    address = models.ForeignKey(
        Address, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'shop'


class ShopProducts(models.Model):
    listing_id = models.FloatField(primary_key=True)
    shop = models.ForeignKey(Shop, models.DO_NOTHING)
    product = models.ForeignKey(Products, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'shop_products'


class Trainer(models.Model):
    trainer_id = models.FloatField(primary_key=True)
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    address = models.ForeignKey(
        Address, models.DO_NOTHING, blank=True, null=True)
    phone_number = models.CharField(max_length=9, blank=True, null=True)
    email = models.CharField(unique=True, max_length=30)

    class Meta:
        managed = False
        db_table = 'trainer'


class TrainerHours(models.Model):
    shift_id = models.FloatField(primary_key=True)
    trainer = models.ForeignKey(
        Trainer, models.DO_NOTHING, blank=True, null=True)
    working = models.ForeignKey(
        'WorkingHours', models.DO_NOTHING, blank=True, null=True)
    member = models.ForeignKey(
        GymMember, models.DO_NOTHING, blank=True, null=True)
    is_active = models.BooleanField(blank=True, null=True)
    is_taken = models.BooleanField(blank=True, null=True)


    class Meta:
        managed = False
        db_table = 'trainer_hours'


class WorkingHours(models.Model):
    working_id = models.FloatField(primary_key=True)
    start_time = models.CharField(max_length=5, blank=True, null=True)
    finish_time = models.CharField(max_length=5, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'working_hours'

        
# class AvailableTrainers(models.Model):
#     id = models.IntegerField(primary_key=True)
#     last_name = models.CharField(max_length = 20, blank=True, null=True)
#     first_name = models.
#     Start = models.CharField(max_length=5, blank=True, null=True)
#     Ending = models.CharField(max_length=5, blank=True, null=True)
    
#     class Meta:
#         managed = False
#         db_table = 'available_trainers'
