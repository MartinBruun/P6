from rest_framework import serializers

from location.models import Location, Service


class LocationSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Location
        fields = ['id','name','created','last_updated','owner','services']
        

class ServiceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Service
        fields = ['id','name','service_type','created','last_updated','location','owner','bookings']