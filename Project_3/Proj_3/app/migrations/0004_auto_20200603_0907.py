# Generated by Django 3.0.6 on 2020-06-03 09:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0003_delete_tags'),
    ]

    operations = [
        migrations.RenameField(
            model_name='comments',
            old_name='owner',
            new_name='ownerID',
        ),
        migrations.AlterField(
            model_name='post',
            name='slug',
            field=models.SlugField(max_length=255),
        ),
    ]