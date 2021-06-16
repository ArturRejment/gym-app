from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from .models import *
from .forms import CreateNewTrainer, UpdateWorkingHours
from rest_framework import generics
from .serializers import *
import datetime

# Create your views here.


def trainer(response, id):
    trainerHours = TrainerHours.objects.all()
    trainer = Trainer.objects.get(trainer_id=id)
    personalData = PersonalData.objects.get(
        personal_data_id=trainer.personal_data_id)
    member = GymMember.objects.all()

    if response.method == "POST":
        if response.POST.get("availability"):
            for hour in trainerHours:
                if response.POST.get("c"+str(hour.shift_id)) == "clicked":
                    if hour.is_active == 1:
                        hour.is_active = 0
                    else:
                        hour.is_active = 1
                    hour.save()

        if response.POST.get("taken"):
            for hour in trainerHours:
                if response.POST.get("c"+str(hour.shift_id)) == "clicked":
                    if hour.member != None:
                        hour.member = None
                    hour.save()

    return render(response, "myapp/trainer.html", {"trainerHours": trainerHours, "trainer": trainer, "trainerData": personalData, "member": member})


def client(response, id):
    trainerHours = TrainerHours.objects.all()
    trainers = Trainer.objects.all()
    client = GymMember.objects.get(member_id=id)
    groupTrainingSchedule = GroupTrainingSchedule.objects.all()
    groupTrainings = GroupTraining.objects.all()
    shopItems = ShopProducts.objects.filter(shop_id=1)

    if response.method == "POST":
        if response.POST.get("save"):
            for hour in trainerHours:
                if response.POST.get("c"+str(hour.shift_id)) == "clicked":
                    hour.member = client
                hour.save()

        elif response.POST.get("saveGroup"):
            for training in groupTrainings:
                if response.POST.get("c"+str(training.group_training_id)) == "clicked":
                    last = GroupTrainingSchedule.objects.last().group_training_schedule_id+1
                    train = GroupTrainingSchedule.objects.create(
                        group_training_schedule_id=last, group_training=training, member=client)

    my_dic = {"client": client,
              "trainerHours": trainerHours,
              "trainers": trainers,
              "groupTrainings": groupTrainings,
              "groupTrainingSchedule": groupTrainingSchedule,
              "shopItems": shopItems}

    return render(response, "myapp/client.html", my_dic)


def index(response):
    return render(response, "myapp/index.html", {})


def receptionist(response, id):
    receptionist = Receptionist.objects.get(receptionist_id=id)

    # Active memberships
    # Active membersips are not woring properly
    # Problem with the dates comparison
    # active_memberships = MemberMemberships.objects.filter(expiry_date__gt = datetime.date.today())
    active_memberships = MemberMemberships.objects.all()
    members = GymMember.objects.all()
    memberships = Membership.objects.all()
    shopItems = ShopProducts.objects.filter(shop_id=1)
    shop = Shop.objects.get(shop_id=1)
    products = Products.objects.all()

    if response.method == "POST":
        if response.POST.get("delProd"):
            # shopItemsForDeletion = ShopProducts.objects.all()
            for product in shopItems:
                if response.POST.get("c"+str(product.listing_id)) == "clicked":
                    product.delete()

        elif response.POST.get("addProd"):
            for productA in products:
                if response.POST.get("c"+str(productA.product_id)) == "clicked":
                    newId = ShopProducts.objects.last().listing_id+1
                    prod = ShopProducts.objects.create(
                        listing_id=newId, shop=shop, product=productA, product_amount=15)

        elif response.POST.get("renew"):
            for membership in memberships:
                if response.POST.get("d"+str(membership.membership_id)) == "clicked":
                    choosenMembership = Membership.objects.get(
                        membership_id=membership.membership_id)

            if choosenMembership != None:
                for memberA in members:
                    if response.POST.get("c"+str(memberA.member_id)) == "clicked":
                        newId = MemberMemberships.objects.last().member_memberships_id + 1
                        st_date = datetime.date.today()
                        end_date = st_date + datetime.timedelta(days=+30)
                        newMembership = MemberMemberships.objects.create(
                            member_memberships_id=newId,
                            membership=choosenMembership,
                            member=memberA,
                            purchase_date=st_date,
                            expiry_date=end_date
                        )

    my_dic = {
        "receptionist": receptionist,
        "active": active_memberships,
        "shopItems": shopItems,
        "shop": shop,
        "products": products,
        "members": members,
        "memberships": memberships
    }

    return render(response, "myapp/receptionist.html", my_dic)
