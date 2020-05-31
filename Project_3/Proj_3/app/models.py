import random
from django.db import models
from django.contrib.auth.models import User, Group
from django.template.defaultfilters import slugify


class Post(models.Model):
    text = models.CharField(max_length=200)
    group = models.ForeignKey('auth.Group', on_delete=models.CASCADE, null=True)  # Field name made lowercase.
    owner = models.ForeignKey(User, on_delete=models.CASCADE)  # Field name made lowercase.
    latitude = models.FloatField()
    longitude = models.FloatField()
    timestamp = models.DateTimeField(blank=True, null=True, auto_now_add=True)
    slug = models.SlugField(unique=False, max_length=255,)

    def save(self, *args, **kwargs):
        if not self.slug:
            slug_id = random.randint(0, 100000000000)
            self.slug = slugify(slug_id)
        super(Post, self).save(*args, **kwargs)

    class Meta:
        ordering = ['timestamp']

        def __unicode__(self):
            return self.title


Group.add_to_class('description', models.CharField(max_length=180, null=True, blank=True))
Group.add_to_class('date_created', models.DateTimeField(null=True, auto_now_add=True))
Group.add_to_class('tag', models.CharField(max_length=180, null=True, blank=True))


class Comments(models.Model):
    text = models.CharField(max_length=200)
    timestamp = models.DateTimeField(null=True, auto_now_add=True)
    post = models.ForeignKey(Post, on_delete=models.CASCADE, null=True)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)






