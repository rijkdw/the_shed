"""Proj_3 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, include
from rest_framework import routers
from app import views


router = routers.DefaultRouter()
router.register('users', views.UserViewSet)
router.register('groups', views.GroupViewSet)
router.register('posts', views.PostViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('admin', include('rest_framework.urls', namespace='rest_framework')),
    path('account/register', views.UserCreate.as_view()),
    path('api/v1/', include(router.urls)),
    path('api/auth/', include('djoser.urls.authtoken')),
]
