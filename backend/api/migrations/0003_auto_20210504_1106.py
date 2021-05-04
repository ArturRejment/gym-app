# Generated by Django 3.1.1 on 2021-05-04 09:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20210503_2315'),
    ]

    operations = [
        migrations.CreateModel(
            name='AvailableTrainers',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('last_name', models.CharField(blank=True, max_length=20, null=True)),
                ('first_name', models.CharField(max_length=20)),
                ('start', models.CharField(max_length=20)),
                ('end', models.CharField(max_length=20)),
            ],
            options={
                'db_table': 'available_trainers',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='GroupTraining',
            fields=[
                ('group_training_id', models.FloatField(primary_key=True, serialize=False)),
                ('group_training_name', models.CharField(blank=True, max_length=30, null=True)),
            ],
            options={
                'db_table': 'group_training',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='GroupTrainingSchedule',
            fields=[
                ('group_training_schedule_id', models.FloatField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'group_training_schedule',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='GymMember',
            fields=[
                ('member_id', models.FloatField(primary_key=True, serialize=False)),
                ('first_name', models.CharField(max_length=20)),
                ('last_name', models.CharField(max_length=20)),
                ('phone_number', models.CharField(blank=True, max_length=9, null=True)),
                ('email', models.CharField(blank=True, max_length=30, null=True)),
            ],
            options={
                'db_table': 'gym_member',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Membership',
            fields=[
                ('membership_id', models.FloatField(primary_key=True, serialize=False)),
                ('purchase_date', models.DateField()),
                ('expiry_date', models.DateField()),
                ('type', models.CharField(max_length=15)),
            ],
            options={
                'db_table': 'membership',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Products',
            fields=[
                ('product_id', models.FloatField(primary_key=True, serialize=False)),
                ('price', models.FloatField()),
                ('product_name', models.CharField(max_length=20)),
            ],
            options={
                'db_table': 'products',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Shop',
            fields=[
                ('shop_id', models.FloatField(primary_key=True, serialize=False)),
                ('shop_name', models.CharField(max_length=20)),
            ],
            options={
                'db_table': 'shop',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ShopProducts',
            fields=[
                ('listing_id', models.FloatField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'shop_products',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Trainer',
            fields=[
                ('trainer_id', models.FloatField(primary_key=True, serialize=False)),
                ('first_name', models.CharField(max_length=20)),
                ('last_name', models.CharField(max_length=20)),
                ('phone_number', models.CharField(blank=True, max_length=9, null=True)),
                ('email', models.CharField(max_length=30, unique=True)),
            ],
            options={
                'db_table': 'trainer',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='TrainerHours',
            fields=[
                ('shift_id', models.FloatField(primary_key=True, serialize=False)),
                ('is_active', models.BooleanField(blank=True, null=True)),
                ('is_taken', models.BooleanField(blank=True, null=True)),
            ],
            options={
                'db_table': 'trainer_hours',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='WorkingHours',
            fields=[
                ('working_id', models.FloatField(primary_key=True, serialize=False)),
                ('start_time', models.CharField(blank=True, max_length=5, null=True)),
                ('finish_time', models.CharField(blank=True, max_length=5, null=True)),
            ],
            options={
                'db_table': 'working_hours',
                'managed': False,
            },
        ),
        migrations.AlterModelOptions(
            name='address',
            options={'managed': False},
        ),
    ]
