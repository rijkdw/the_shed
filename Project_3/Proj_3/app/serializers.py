
from rest_framework import serializers

from django.contrib.auth.models import User, Group
from app.models import Post, Comments


class GroupSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Group
        fields = ['name', 'id', 'description', 'date_created']


class PostSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.CurrentUserDefault()

    class Meta:
        model = Post
        fields = "__all__"
        ordering = ['timestamp']


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.set_password(password)
        user.save()
        return user

    class Meta:
        model = User
        fields = ['username', 'password', 'id']
        extra_kwargs = {'password': {'write_only': True}}


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comments
        fields = '__all__'

