"""washee_web URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
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
from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from django.conf import settings
from django.conf.urls.static import static
from rest_framework.authtoken import views

from upload.views import image_upload
from account.view_sets import UserViewSet, AccountViewSet
from booking.view_sets import BookingViewSet
from location.view_sets import (
    LocationViewSet, MachineViewSet, MachineModelViewSet, ServiceViewSet
)

# Routes
router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'accounts', AccountViewSet)
router.register(r"bookings", BookingViewSet)
router.register(r"locations", LocationViewSet)
router.register(r"machines", MachineViewSet)
router.register(r"machine_models", MachineModelViewSet)
router.register(r"services", ServiceViewSet)

from django.http import HttpResponse
def homePageView(request):
    return HttpResponse("Hello, World!")

urlpatterns = [
    path('washee_admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls', namespace="rest_framework")),
    path('api-token-auth/', views.obtain_auth_token,name='api-token-auth'),
    path('upload/', image_upload, name="upload"),
    path('api/1/', include(router.urls), name="api"),
    path('admin/', include('admin_honeypot.urls', namespace='admin_honeypot')),
    path("", homePageView, name="home")
]

if bool(settings.DEBUG):
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)