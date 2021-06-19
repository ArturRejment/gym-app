from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Address(models.Model):
    address_id = models.AutoField(primary_key=True)
    postcode = models.CharField(max_length=20)
    city = models.CharField(max_length=20)
    street = models.CharField(max_length=20)

    def __str__(self):
        return self.city + ' ' + self.street

    class Meta:
        managed = False
        db_table = 'address'


class GroupTraining(models.Model):
    group_training_id = models.AutoField(primary_key=True)
    group_training_name = models.CharField(max_length=30)
    trainer = models.ForeignKey('Trainer', models.DO_NOTHING)
    working = models.ForeignKey('WorkingHours', models.DO_NOTHING)

    def __str__(self):
        return self.group_training_name

    class Meta:
        managed = False
        db_table = 'group_training'


class GroupTrainingSchedule(models.Model):
    group_training_schedule_id = models.AutoField(primary_key=True)
    group_training = models.ForeignKey(GroupTraining, models.DO_NOTHING)
    member = models.ForeignKey('GymMember', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'group_training_schedule'


class GymMember(models.Model):
    member_id = models.AutoField(primary_key=True)
    personal_data = models.ForeignKey('PersonalData', models.DO_NOTHING)
    sign_up_date = models.DateField(auto_now_add=True)
    is_suspended = models.BooleanField(blank=True, default=False)
    user = models.OneToOneField(User, null=True, blank=True, on_delete=models.DO_NOTHING)


    def __str__(self):
        return f'Member {self.personal_data}'

    class Meta:
        managed = False
        db_table = 'gym_member'


class MemberMemberships(models.Model):
    member_memberships_id = models.AutoField(primary_key=True)
    membership = models.ForeignKey('Membership', models.DO_NOTHING)
    member = models.ForeignKey(GymMember, models.DO_NOTHING)
    purchase_date = models.DateField()
    expiry_date = models.DateField()

    def __str__(self):
        return f'{self.member} until {self.expiry_date}'

    class Meta:
        managed = False
        db_table = 'member_memberships'


class Membership(models.Model):
    membership_id = models.AutoField(primary_key=True)
    membership_type = models.CharField(max_length=30)
    membership_price = models.DecimalField(
        max_digits=65535, decimal_places=65535)

    class Meta:
        managed = False
        db_table = 'membership'

    def __str__(self):
        return self.membership_type

class PersonalData(models.Model):
    personal_data_id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    address = models.ForeignKey(Address, models.DO_NOTHING, null=True)
    phone_number = models.CharField(max_length=9, blank=True, null=True)
    email = models.CharField(unique=True, max_length=50)

    def __str__(self):
        return self.first_name + ' ' + self.last_name

    class Meta:
        managed = False
        db_table = 'personal_data'


class Products(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_price = models.DecimalField(max_digits=65535, decimal_places=65535)
    product_name = models.CharField(max_length=20)

    def __str__(self):
        return self.product_name

    class Meta:
        managed = False
        db_table = 'products'


class Receptionist(models.Model):
    receptionist_id = models.AutoField(primary_key=True)
    personal_data = models.ForeignKey(PersonalData, models.DO_NOTHING)
    is_senior_receptionist = models.BooleanField(blank=True, null=True)
    user = models.OneToOneField(User, null=True, blank=True, on_delete=models.DO_NOTHING)

    def __str__(self):
        return f'Receptionist {self.personal_data}'

    class Meta:
        managed = False
        db_table = 'receptionist'


class Shop(models.Model):
    shop_id = models.AutoField(primary_key=True)
    shop_name = models.CharField(max_length=20)
    address = models.ForeignKey(
        Address, models.DO_NOTHING, blank=True, null=True)

    def __str__(self):
        return  self.shop_name

    class Meta:
        managed = False
        db_table = 'shop'


class ShopProducts(models.Model):
    listing_id = models.AutoField(primary_key=True)
    shop = models.ForeignKey(Shop, models.DO_NOTHING)
    product = models.ForeignKey(Products, models.DO_NOTHING)
    product_amount = models.IntegerField()

    def __str__(self):
        return f'{self.product} in {self.shop}'

    class Meta:
        managed = False
        db_table = 'shop_products'


class Trainer(models.Model):
    trainer_id = models.AutoField(primary_key=True)
    personal_data = models.ForeignKey(PersonalData, models.DO_NOTHING)
    number_of_certifications = models.IntegerField(blank=True, null=True)
    user = models.OneToOneField(User, null=True, blank=True, on_delete=models.DO_NOTHING)

    def __str__(self):
        return f'Trainer {self.personal_data}'

    class Meta:
        managed = False
        db_table = 'trainer'


class TrainerHours(models.Model):
    shift_id = models.AutoField(primary_key=True)
    trainer = models.ForeignKey(Trainer, models.DO_NOTHING)
    working = models.ForeignKey('WorkingHours', models.DO_NOTHING)
    member = models.ForeignKey(
        GymMember, models.DO_NOTHING, blank=True, null=True)
    is_active = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'trainer_hours'


class WorkingHours(models.Model):
    working_id = models.AutoField(primary_key=True)
    start_time = models.CharField(max_length=5)
    finish_time = models.CharField(max_length=5)

    def __str__(self):
        return self.start_time + ' - ' + self.finish_time

    class Meta:
        managed = False
        db_table = 'working_hours'

class Hello(models.Model):
    user = models.OneToOneField(User, null=True, on_delete=models.CASCADE)
