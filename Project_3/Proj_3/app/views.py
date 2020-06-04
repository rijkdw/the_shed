from app.permissions import IsOwnerOrReadOnly
from rest_framework import viewsets, generics
from rest_framework import permissions
from .serializers import UserSerializer, GroupSerializer, PostSerializer, CommentSerializer
from .models import Post, Comments
from django.contrib.auth.models import User, Group
from django_filters import rest_framework as filters


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = (filters.DjangoFilterBackend,)
    filter_fields = ('username', 'id')


class GroupViewSet(viewsets.ModelViewSet):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = (filters.DjangoFilterBackend,)
    filter_fields = ('name', 'id', 'description', 'date_created', 'tag', 'created_by')

    def perform_create(self, serializer):
        serializer.save(created_by=self.request.user)
        self.request.user.groups.add()


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly]
    filter_backends = (filters.DjangoFilterBackend,)
    filter_fields = ('timestamp', 'latitude', 'longitude', 'owner', 'group')

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)


class CommentsViewSet(viewsets.ModelViewSet):
    queryset = Comments.objects.all()
    serializer_class = CommentSerializer
    permission_classes = [IsOwnerOrReadOnly, permissions.IsAuthenticatedOrReadOnly]
    filter_backends = (filters.DjangoFilterBackend,)
    filter_fields = ('text', 'timestamp', 'post', 'owner')

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)


class UserCreate(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = (permissions.AllowAny,)
