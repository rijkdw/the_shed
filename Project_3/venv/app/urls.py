from django.urls import include, path
from rest_framework import routers
from app import views


router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', view.GroupViewSet)
router.register(r'posts', views.PostViewSet)

urlpatters = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]