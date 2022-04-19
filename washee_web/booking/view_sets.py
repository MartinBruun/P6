from rest_framework import viewsets

from booking.models import Booking
from booking.serializers import BookingSerializer

class BookingViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    
    def get_queryset(self):
        queryset = Booking.objects.all().filter(active=True)
        
        start_time__gte = self.request.query_params.get('start_time__gte')
        if start_time__gte is not None:
            queryset = queryset.filter(start_time__gte=start_time__gte)
        start_time__lte = self.request.query_params.get('start_time__lte')
        if start_time__lte is not None:
            queryset = queryset.filter(start_time__lte=start_time__lte)
        end_time__gte = self.request.query_params.get('end_time__gte')
        if end_time__gte is not None:
            queryset = queryset.filter(end_time__gte=end_time__gte)
        end_time__lte = self.request.query_params.get('end_time__lte')
        if end_time__lte is not None:
            queryset = queryset.filter(end_time__lte=end_time__lte)
        account_id = self.request.query_params.get('account_id')
        if account_id is not None:
            queryset = queryset.filter(account=account_id)
        service_id = self.request.query_params.get('service_id')
        if service_id is not None:
            queryset = queryset.filter(service=service_id)
        machine_id = self.request.query_params.get('machine_id')
        if machine_id is not None:
            queryset = queryset.filter(machine=machine_id)
        
        return queryset