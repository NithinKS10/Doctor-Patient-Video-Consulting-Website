# Generated by Django 5.0 on 2024-09-17 06:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dispensaryapp', '0004_category_icd_details_sub_category'),
    ]

    operations = [
        migrations.AddField(
            model_name='prescription',
            name='icd_details_id',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
    ]
