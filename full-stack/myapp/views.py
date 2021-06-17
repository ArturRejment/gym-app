from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import CreateNewTrainer, UpdateWorkingHours

import datetime
from .serializers import *
from .models import *
from .decorators import unauthenticated_user, allowed_users
from .filters import TrainerFilter


#! Client Page
@login_required(login_url = 'login')
@allowed_users(allowed_roles=['trainer'])
def trainerUpdate(request):
    trainerHours = request.user.trainer.trainerhours_set.all()

    if request.method == "POST":
        if request.POST.get("availability"):
            for hour in trainerHours:
                if request.POST.get("c"+str(hour.shift_id)) == "clicked":
                    if hour.is_active == 1:
                        hour.is_active = 0
                    else:
                        hour.is_active = 1
                    hour.save()

        if request.POST.get("taken"):
            for hour in trainerHours:
                if request.POST.get("c"+str(hour.shift_id)) == "clicked":
                    if hour.member != None:
                        hour.member = None
                    hour.save()

    return render(request, "myapp/trainer.html", {"trainerHours": trainerHours})

#! Client Page
@login_required(login_url = 'login')
@allowed_users(allowed_roles=['member'])
def client(request):
    trainerHours = TrainerHours.objects.all()
    trainers = Trainer.objects.all()
    client = request.user.gymmember
    groupTrainingSchedule = GroupTrainingSchedule.objects.all()
    groupTrainings = GroupTraining.objects.all()
    shopItems = ShopProducts.objects.filter(shop_id=1).order_by('product__product_name')


    myFilter = TrainerFilter(request.GET, queryset = trainers)
    trainers = myFilter.qs

    if request.method == "POST":
        if request.POST.get("save"):
            for hour in trainerHours:
                if request.POST.get("c"+str(hour.shift_id)) == "clicked":
                    hour.member = client
                hour.save()

        elif request.POST.get("saveGroup"):
            for training in groupTrainings:
                if request.POST.get("c"+str(training.group_training_id)) == "clicked":
                    last = GroupTrainingSchedule.objects.last().group_training_schedule_id+1
                    train = GroupTrainingSchedule.objects.create(
                        group_training_schedule_id=last, group_training=training, member=client)

    my_dic = {"client": client,
              "trainerHours": trainerHours,
              "trainers": trainers,
              "groupTrainings": groupTrainings,
              "groupTrainingSchedule": groupTrainingSchedule,
              "shopItems": shopItems,
              "trainerFilter": myFilter
              }

    return render(request, "myapp/client.html", my_dic)

#! Index Page
def index(response):
    return render(response, "myapp/index.html", {})

#! Logout Page
def logoutPage(request):

    logout(request)

    return redirect('index')

#! Login Page
@unauthenticated_user
def loginPage(request):

    if request.method == "POST":
        username = request.POST.get('email')
        password = request.POST.get('password')

        user = authenticate(request, username=username, password=password)

        group = None

        if user is not None:
            login(request, user)
            if request.user.groups.exists():
                group = request.user.groups.all()[0].name

            if group == 'trainer':
                return redirect('trainerPage')
            elif group == 'member':
                return redirect('client')
            elif group == 'receptionist':
                return redirect('receptionist')

            if group == None:
                return HttpResponse("Your account do not have valid pemissions! Please, contact with receptionist")
        else:
            messages.info(request, 'Username or password is incorrect!')

    context = {}

    return render(request, "myapp/login.html", context)

#! Receptionist Page
@login_required(login_url = 'login')
@allowed_users(allowed_roles=['receptionist'])
def receptionist(request):
    receptionist = request.user.receptionist

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

    if request.method == "POST":
        if request.POST.get("delProd"):
            # shopItemsForDeletion = ShopProducts.objects.all()
            for product in shopItems:
                if request.POST.get("c"+str(product.listing_id)) == "clicked":
                    product.delete()

        elif request.POST.get("addProd"):
            for productA in products:
                if request.POST.get("c"+str(productA.product_id)) == "clicked":
                    newId = ShopProducts.objects.last().listing_id+1
                    prod = ShopProducts.objects.create(
                        listing_id=newId, shop=shop, product=productA, product_amount=15)

        elif request.POST.get("renew"):
            for membership in memberships:
                if request.POST.get("d"+str(membership.membership_id)) == "clicked":
                    choosenMembership = Membership.objects.get(
                        membership_id=membership.membership_id)

            if choosenMembership != None:
                for memberA in members:
                    if request.POST.get("c"+str(memberA.member_id)) == "clicked":
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

    return render(request, "myapp/receptionist.html", my_dic)

@login_required(login_url = 'login')
@allowed_users(allowed_roles=['trainer'])
def trainerPage(request):

    trainerHours = request.user.trainer.trainerhours_set.all()
    print(trainerHours)

    trainer = request.user.trainer

    context = {
        "trainerHours": trainerHours,
    }
    return render(request, "myapp/trainer.html", context)


def buyProduct(request, **kwargs):

    product = ShopProducts.objects.get(listing_id = kwargs['id'])
    print(product)

    product.product_amount -= 1
    product.save()

    return redirect('client')
