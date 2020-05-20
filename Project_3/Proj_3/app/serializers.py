
from rest_framework import serializers

from django.contrib.auth.models import User, Group
from app.models import Post


class UserSerializer(serializers.ModelSerializer):


    class Meta:
        model = User
        fields = ['username', 'id']


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    posts = serializers.PrimaryKeyRelatedField(many=True, queryset=Post.objects.all())

    class Meta:
        model = Group
        fields = ['name', 'id', 'description', 'date_created', 'posts']


class PostSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='users.username')

    class Meta:
        model = Post
        fields = "__all__"
        ordering = ['created_on']


