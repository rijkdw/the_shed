
from rest_framework import serializers

from django.contrib.auth.models import User, Group
from app.models import Post, Comments


class CurrentUserDefault(object):
    def set_context(self, serializer_field):
        self.user_id = serializer_field.context['request'].user.id

    def __call__(self):
        return self.user_id

    def __repr__(self):
        return '%s()' % self.__class__.__name__


class GroupSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Group
        fields = ['name', 'id', 'description', 'date_created', 'tag']


class PostSerializer(serializers.HyperlinkedModelSerializer):
    owner_id = serializers.IntegerField(default=CurrentUserDefault(), read_only=True)
    owner = serializers.CharField(source='owner.username', read_only=True)
    group_id = serializers.IntegerField(read_only=True)
    group_name = serializers.CharField(source='group.name', read_only=True)

    class Meta:
        model = Post
        fields = "__all__"
        extra_fields = ['id']
        read_only_fields = ['slug', 'owner_id', 'group_id', 'group_name']
        ordering = ['timestamp']

    def get_field_names(self, declared_fields, info):
        expanded_fields = super(PostSerializer, self).get_field_names(declared_fields, info)

        if getattr(self.Meta, 'extra_fields', None):
            return expanded_fields + self.Meta.extra_fields
        else:
            return expanded_fields


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        groups_data = validated_data.pop('groups')
        password = validated_data.pop('password')
        email = validated_data.pop('email')
        user = User(**validated_data)
        user.set_password(password)
        for group_data in groups_data:
            user.groups.add(group_data)
        user.save()
        return user

    class Meta:
        model = User
        fields = ['username', 'password', 'id', 'groups', 'email']
        extra_kwargs = {'password': {'write_only': True}}


class CommentSerializer(serializers.ModelSerializer):
    owner = serializers.CurrentUserDefault()

    class Meta:
        model = Comments
        fields = '__all__'

