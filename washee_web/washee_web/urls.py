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

from account.token_view import UserAndAuthToken
from upload.views import image_upload
from account.view_sets import UserViewSet, AccountViewSet
from booking.view_sets import BookingViewSet
from location.view_sets import (
    LocationViewSet, MachineViewSet, MachineModelViewSet, ServiceViewSet
)
from electricity.view_sets import ElectricityBlockViewSet
from security.view_sets import LogViewSet

# Routes
router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'accounts', AccountViewSet)
router.register(r"bookings", BookingViewSet)
router.register(r"locations", LocationViewSet)
router.register(r"machines", MachineViewSet)
router.register(r"machine_models", MachineModelViewSet)
router.register(r"services", ServiceViewSet)
router.register(r"electricity_blocks", ElectricityBlockViewSet)
router.register(r"logs", LogViewSet)

from django.http import HttpResponse
def homePageView(request):
    return HttpResponse("Hello, World!")

import os
def downloadWashee(request):
    washee_web_path = os.getcwd()
    path_to_apk = washee_web_path + "/washee_web/app-release.apk"
    with open(path_to_apk, "br") as fh:
        response = HttpResponse(fh, headers={
            "Content-Type": "application/vnd.android.package-archive",
            "Content-Disposition" : "attachment; filename={}".format(os.path.basename(path_to_apk))
        })
        return response

urlpatterns = [
    path('washee-admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls', namespace="rest_framework")),
    path('api-token-auth/', UserAndAuthToken.as_view(),name='api-token-auth'),
    path('upload/', image_upload, name="upload"),
    path('api/1/', include(router.urls), name="api"),
    #path('admin/', include('admin_honeypot.urls', namespace='admin_honeypot')), # Not working, see explanation in settings under INSTALLED_APPS
    path('download/', downloadWashee, name="download"),
    path("", homePageView, name="home")
]

if bool(settings.DEBUG):
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)