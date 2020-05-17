from django.db import models
from django.utils import timezone


class Post(models.Model):
    id = models.fields.IntegerField(primary_key=True)
    text = models.TextField()
    Group_id = models.ForeignKey('auth.Group', related_name='post', on_delete=models.CASCADE)
    latitude = models.fields.FloatField()
    longitude = models.fields.FloatField()
    timestamp = models.DateTimeField()
    Users_id = models.ForeignKey('auth.User', related_name='posts', on_delete=models.CASCADE)

    def save(self, *args, **kwargs):          #when a post is created the date is automatically updated
        if not self.id:
            self.timestamp = timezone.now()
        return super(Post, self).save(*args, **kwargs)

class Messages(models.Model):
    id = models.fields.IntegerField(primary_key=True)
    text = models.TextField()
    timestamp = models.DateTimeField()
    sender_id = models.ForeignKey('auth.User', related_name='message', on_delete=models.CASCADE)

    def save(self, *args, **kwargs):          #when a message is created the date is automatically updated
        if not self.id:
            self.date = timezone.now()
        return super(Messages, self).save(*args, **kwargs)
