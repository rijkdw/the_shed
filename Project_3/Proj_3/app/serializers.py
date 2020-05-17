from django.contrib.auth.models import User, Group
from rest_framework import serializers
from app.models import Post, Messages


class UserSerializer(serializers.HyperlinkedModelSerializer):
    posts = serializers.PrimaryKeyRelatedField(many=True, queryset=Post.objects.all())

    class Meta:
        model = User
        fields = ['id', 'username', 'password']


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['id', 'name', 'date_created', 'description']


class PostSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Post
        fields = ['id', ' timestamp', 'text', 'users_id', 'group_id','latitude', 'longitude']


class MessageSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Messages
        fields = ['id', 'timestamp', 'text', 'sender_id'
                                             '']