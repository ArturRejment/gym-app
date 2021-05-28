from django.db import models

# Create your models here.


class Address(models.Model):
    address_id = models.FloatField(primary_key=True)
    postcode = models.CharField(max_length=20)
    city = models.CharField(max_length=20)
    street = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'address'


class GroupTraining(models.Model):
    group_training_id = models.FloatField(primary_key=True)
    group_training_name = models.CharField(max_length=30)
    trainer = models.ForeignKey('Trainer', models.DO_NOTHING)
    working = models.ForeignKey('WorkingHours', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'group_training'


class GroupTrainingSchedule(models.Model):
    group_training_schedule_id = models.FloatField(primary_key=True)
    group_training = models.ForeignKey(GroupTraining, models.DO_NOTHING)
    member = models.ForeignKey('GymMember', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'group_training_schedule'


class GymMember(models.Model):
    member_id = models.FloatField(primary_key=True)
    personal_data = models.ForeignKey('PersonalData', models.DO_NOTHING)
    sign_up_date = models.DateField()
    is_suspended = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'gym_member'


class MemberMemberships(models.Model):
    member_memberships_id = models.FloatField(primary_key=True)
    membership = models.ForeignKey('Membership', models.DO_NOTHING)
    member = models.ForeignKey(GymMember, models.DO_NOTHING)
    purchase_date = models.DateField()
    expiry_date = models.DateField()

    class Meta:
        managed = False
        db_table = 'member_memberships'


class MembersHistoryLog(models.Model):
    member = models.OneToOneField(
        GymMember, models.DO_NOTHING, primary_key=True)
    sign_up_date = models.DateField()
    account_susp_date = models.DateField()
    previous_account_state = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'members_history_log'
        unique_together = (('member', 'account_susp_date'),)


class Membership(models.Model):
    membership_id = models.FloatField(primary_key=True)
    membership_type = models.CharField(max_length=30)
    membership_price = models.FloatField()

    class Meta:
        managed = False
        db_table = 'membership'


class PersonalData(models.Model):
    personal_data_id = models.FloatField(primary_key=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    address = models.ForeignKey(Address, models.DO_NOTHING)
    phone_number = models.CharField(max_length=9, blank=True, null=True)
    email = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'personal_data'


class Products(models.Model):
    product_id = models.FloatField(primary_key=True)
    product_price = models.FloatField()
    product_name = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'products'


class Receptionist(models.Model):
    receptionist_id = models.FloatField(primary_key=True)
    personal_data = models.ForeignKey(PersonalData, models.DO_NOTHING)
    is_senior_receptionist = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'receptionist'


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
    personal_data = models.ForeignKey(PersonalData, models.DO_NOTHING)
    number_of_certifications = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'trainer'


class TrainerHours(models.Model):
    shift_id = models.FloatField(primary_key=True)
    trainer = models.ForeignKey(Trainer, models.DO_NOTHING)
    working = models.ForeignKey('WorkingHours', models.DO_NOTHING)
    member = models.ForeignKey(
        GymMember, models.DO_NOTHING, blank=True, null=True)
    is_active = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'trainer_hours'


class WorkingHours(models.Model):
    working_id = models.FloatField(primary_key=True)
    start_time = models.CharField(max_length=5)
    finish_time = models.CharField(max_length=5)

    class Meta:
        managed = False
        db_table = 'working_hours'
