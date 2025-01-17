# Generated by Django 5.0 on 2024-02-12 12:34

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Appointment',
            fields=[
                ('appointment_id', models.AutoField(primary_key=True, serialize=False)),
                ('doctor_login_id', models.IntegerField()),
                ('patient_login_id', models.IntegerField()),
                ('appointment_date', models.DateField()),
                ('entry_date', models.DateTimeField(default=datetime.datetime.now)),
                ('status', models.CharField(default='Not Consulted', max_length=50)),
            ],
            options={
                'db_table': 'tbl_appointment',
            },
        ),
        migrations.CreateModel(
            name='Complaint',
            fields=[
                ('complaint_id', models.AutoField(primary_key=True, serialize=False)),
                ('complaint', models.CharField(max_length=150)),
                ('user_login_id', models.IntegerField()),
                ('reply', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_complaint',
            },
        ),
        migrations.CreateModel(
            name='District',
            fields=[
                ('district_id', models.AutoField(primary_key=True, serialize=False)),
                ('state_id', models.IntegerField()),
                ('district', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_district',
            },
        ),
        migrations.CreateModel(
            name='Doctor',
            fields=[
                ('doctor_id', models.AutoField(primary_key=True, serialize=False)),
                ('login_id', models.IntegerField()),
                ('doctor_first_name', models.CharField(max_length=50)),
                ('doctor_last_name', models.CharField(max_length=50)),
                ('address', models.CharField(max_length=50, null=True)),
                ('email', models.CharField(max_length=50)),
                ('phone_number', models.BigIntegerField(null=True)),
                ('district_id', models.IntegerField()),
                ('place', models.CharField(max_length=50)),
                ('medical_speciality_id', models.IntegerField()),
                ('qualification', models.CharField(max_length=50, null=True)),
                ('photo', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_doctor',
            },
        ),
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('feedback_id', models.AutoField(primary_key=True, serialize=False)),
                ('feedback', models.CharField(max_length=150)),
                ('user_login_id', models.IntegerField()),
                ('reply', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_feedback',
            },
        ),
        migrations.CreateModel(
            name='Insurance',
            fields=[
                ('insurance_id', models.AutoField(primary_key=True, serialize=False)),
                ('insuarnce_company', models.CharField(max_length=50)),
                ('description', models.CharField(max_length=500)),
            ],
            options={
                'db_table': 'tbl_insurance',
            },
        ),
        migrations.CreateModel(
            name='Lab',
            fields=[
                ('lab_id', models.AutoField(primary_key=True, serialize=False)),
                ('login_id', models.IntegerField()),
                ('name', models.CharField(max_length=50)),
                ('address', models.CharField(max_length=50, null=True)),
                ('email', models.CharField(max_length=50)),
                ('phone_number', models.BigIntegerField(null=True)),
                ('place', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_lab',
            },
        ),
        migrations.CreateModel(
            name='lab_test',
            fields=[
                ('lab_test_id', models.AutoField(primary_key=True, serialize=False)),
                ('appointment_id', models.IntegerField()),
                ('test_id', models.IntegerField()),
                ('status', models.CharField(default='Result is not Prepared', max_length=50)),
                ('result', models.CharField(max_length=50, null=True)),
                ('description', models.TextField(null=True)),
                ('entry_date', models.DateTimeField(default=datetime.datetime.now)),
            ],
            options={
                'db_table': 'tbl_lab_test',
            },
        ),
        migrations.CreateModel(
            name='lab_test_type',
            fields=[
                ('lab_test_type_id', models.AutoField(primary_key=True, serialize=False)),
                ('tests', models.CharField(max_length=50)),
                ('lab_login_id', models.IntegerField()),
            ],
            options={
                'db_table': 'tbl_lab_test_type',
            },
        ),
        migrations.CreateModel(
            name='Login',
            fields=[
                ('login_id', models.AutoField(primary_key=True, serialize=False)),
                ('username', models.CharField(max_length=50)),
                ('password', models.TextField(null=True)),
                ('Usertype', models.CharField(max_length=50)),
                ('status', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_login',
            },
        ),
        migrations.CreateModel(
            name='MedicalSpeciality',
            fields=[
                ('medical_speciality_id', models.AutoField(primary_key=True, serialize=False)),
                ('speciality', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_medical_speciality',
            },
        ),
        migrations.CreateModel(
            name='Patients',
            fields=[
                ('patient_id', models.AutoField(primary_key=True, serialize=False)),
                ('login_id', models.IntegerField()),
                ('patient_name', models.CharField(max_length=50, null=True)),
                ('phone_number', models.BigIntegerField(null=True)),
                ('Address', models.TextField()),
                ('district_id', models.IntegerField()),
                ('place', models.CharField(max_length=50, null=True)),
                ('dob', models.DateField()),
                ('entry_date', models.DateTimeField(default=datetime.datetime.now)),
            ],
            options={
                'db_table': 'tbl_patient',
            },
        ),
        migrations.CreateModel(
            name='prescription',
            fields=[
                ('prescription_id', models.AutoField(primary_key=True, serialize=False)),
                ('appointment_id', models.IntegerField()),
                ('visiting_date', models.DateField()),
                ('symptoms', models.TextField()),
                ('medicine', models.TextField()),
                ('uses', models.TextField()),
                ('details', models.TextField()),
                ('entry_date', models.DateTimeField(default=datetime.datetime.now)),
            ],
            options={
                'db_table': 'tbl_prescription',
            },
        ),
        migrations.CreateModel(
            name='State',
            fields=[
                ('state_id', models.AutoField(primary_key=True, serialize=False)),
                ('country_id', models.IntegerField()),
                ('state', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tbl_state',
            },
        ),
    ]
