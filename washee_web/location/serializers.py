from rest_framework import serializers

from location.models import Location, Machine, MachineModel, Service


class LocationSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Location
        fields = ['id','name','created','last_updated','owner','machines']
        
class MachineSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Machine
        fields = ['id','name','created','last_updated','model','location', 'owner','bookings']
        
class MachineModelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = MachineModel
        fields = ['id','name','created','last_updated','services']

class ServiceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Service
        fields = ['id','name','price_in_dk','duration_in_sec','created','last_updated','machine_model', 'bookings']