from django.contrib.auth.models import User, Group
from rest_framework import serializers
from app.models import Post


class UserSerializer(serializers.HyperlinkedModelSerializer):
    posts = serializers.PrimaryKeyRelatedField(many=True, queryset=Post.objects.all())
    class Meta:
        model = User
        fields = ['user_id', 'username', 'password']


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['group_id', 'date_created', 'group_name']


class PostSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Post
        fields - ['post_id', ' date', 'Post_col', 'owner']