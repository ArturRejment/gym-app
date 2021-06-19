from django.db.models.signals import post_save
from django.contrib.auth.models import User, Group
from .models import GymMember, PersonalData, Address

def member_profile(sender, instance, created, **kwargs):
    if created:
        group = Group.objects.get(name='member')
        instance.groups.add(group)

        address = Address.objects.create(
			address_id=Address.objects.last().address_id + 1,
			postcode= getattr(instance, '_postcode', None),
			city=getattr(instance, '_city', None),
			street = getattr(instance, '_street', None)
		)

        data = PersonalData.objects.create(
			personal_data_id = PersonalData.objects.last().personal_data_id + 1,
			first_name=instance.first_name,
			last_name=instance.last_name,
			email=instance.email,
			phone_number=getattr(instance, '_phone', None),
			address = address
		)

        GymMember.objects.create(
			member_id = GymMember.objects.last().member_id + 1,
			user=instance,
            personal_data=data
		)

        print('Profile created!!!')

post_save.connect(member_profile, sender=User)