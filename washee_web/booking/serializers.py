from rest_framework import serializers

from booking.models import Booking


class BookingSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Booking
        fields = ['name']