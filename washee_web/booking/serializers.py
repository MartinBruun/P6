from rest_framework import serializers

from booking.models import Booking


class BookingSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Booking
        fields = ['id','start_time','end_time','created','last_updated','activated','machine','service','account']