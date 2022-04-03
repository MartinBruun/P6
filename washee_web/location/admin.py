from django.contrib import admin

from location.models import Location, Machine, MachineModel, Service

admin.site.register(Location)
admin.site.register(Machine)
admin.site.register(MachineModel)
admin.site.register(Service)