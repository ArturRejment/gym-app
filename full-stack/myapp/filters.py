import django_filters
from django_filters import ModelChoiceFilter
from .models import *

class TrainerFilter(django_filters.FilterSet):

    personal = Trainer.objects.all()

    # data = ModelChoiceFilter(queryset=personal, label='Search for Trainer ')

    class Meta:
        model = Trainer
        fields = ['personal_data']

    def __init__(self, *args, **kwargs):
        super(TrainerFilter, self).__init__(*args, **kwargs)
        self.filters['personal_data'].extra.update(
            {'empty_label': 'All trainers'})