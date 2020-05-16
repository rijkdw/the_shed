from django.db import models
from django.utils import timezone


class Post(models.Model):
    post_id = models.fields.IntegerField(read_only=True)
    date = models.DateTimeField()
    Posts_col = models.TextField()
    owner = models.ForeignKey('auth.User', related_name='posts', on_delete=models.CASCADE())

    def save(self, *args, **kwargs):          #when a post is created the date is automatically updated
        if not self.id:
            self.date = timezone.now()
        return super(User, self).save(*args, **kwargs)