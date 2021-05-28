from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from .models import *
from .forms import CreateNewTrainer, UpdateWorkingHours
from rest_framework import generics
from .serializers import *

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
                    if hour.is_taken == 1:
                        hour.member = None
                        hour.is_taken = 0
                    hour.save()

    return render(response, "myapp/trainer.html", {"trainerHours": trainerHours, "trainer": trainer, "trainerData": personalData, "member":member})


def client(response, id):
    trainerHours = TrainerHours.objects.all()
    trainers = Trainer.objects.all()
    client = GymMember.objects.get(member_id=id)
    groupTrainingSchedule = GroupTrainingSchedule.objects.all()
    groupTrainings = GroupTraining.objects.all()
    shopItems = ShopProducts.objects.all()

    if response.method == "POST":
        if response.POST.get("save"):
            for hour in trainerHours:
                if response.POST.get("c"+str(hour.shift_id)) == "clicked":
                    hour.member = client
                    hour.is_taken = 1
                hour.save()

    my_dic = {"client": client,
              "trainerHours": trainerHours,
              "trainers": trainers,
              "groupTrainings": groupTrainings,
              "groupTrainingSchedule": groupTrainingSchedule,
              "shopItems": shopItems}

    return render(response, "myapp/client.html", my_dic)


def index(response):
    return render(response, "myapp/index.html", {})


def add(response):
    # if response.method == "POST":
    #     form = CreateNewTrainer(response.POST)
    #     if form.is_valid():
    #         n = form.cleaned_data["firstname"]
    #         ln = form.cleaned_data["lastname"]
    #         i = form.cleaned_data["id"]

    #         t = Trainer(firstname=n, lastname=ln, id=i)
    #         t.save()

    # else:
    form = CreateNewTrainer()
    return render(response, "myapp/add.html", {"form": form})
