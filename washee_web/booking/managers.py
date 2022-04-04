from django.db.models import Manager

class BookingManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()