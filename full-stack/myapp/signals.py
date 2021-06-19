from django.db.models.signals import post_save
from django.contrib.auth.models import User, Group
from .models import GymMember, PersonalData

def member_profile(sender, instance, created, **kwargs):
    if created:
        group = Group.objects.get(name='member')
        instance.groups.add(group)

        data = PersonalData.objects.create(
			first_name=instance.first_name,
			last_name=instance.last_name,
			email = instance.email
		)

        GymMember.objects.create(
			user=instance,
            personal_data = data
		)

        print('Profile created!!!')

post_save.connect(member_profile, sender=User)