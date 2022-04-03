from rest_framework import viewsets

from location.models import Location, Machine, MachineModel, Service
from location.serializers import (
    LocationSerializer, MachineSerializer, MachineModelSerializer, ServiceSerializer
)

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer
    
class MachineViewSet(viewsets.ModelViewSet):
    queryset = Machine.objects.all()
    serializer_class = MachineSerializer
    
class MachineModelViewSet(viewsets.ModelViewSet):
    queryset = MachineModel.objects.all()
    serializer_class = MachineModelSerializer

class ServiceViewSet(viewsets.ModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer