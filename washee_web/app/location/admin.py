from django.contrib import admin

from location.models import Location, Service

admin.site.register(Location)
admin.site.register(Service)