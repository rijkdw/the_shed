
from django.db import models
from django.contrib.auth.models import User, Group
from django.template.defaultfilters import slugify

Group.add_to_class('description', models.CharField(max_length=180, null=True, blank=True))
Group.add_to_class('date_created', models.DateTimeField(null=True, auto_now_add=True))


class Post(models.Model):
    text = models.CharField(max_length=200)
    group = models.ForeignKey('auth.Group', on_delete=models.CASCADE, null=True)  # Field name made lowercase.
    owner = models.ForeignKey('auth.User', on_delete=models.CASCADE)  # Field name made lowercase.
    latitude = models.FloatField()
    longitude = models.FloatField()
    timestamp = models.DateTimeField(blank=True, null=True, auto_now_add=True)
    slug = models.SlugField(unique=True, max_length=255)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)
        super(Post, self).save(*args, **kwargs)

    class Meta:
        ordering = ['timestamp']

        def __unicode__(self):
            return self.title






