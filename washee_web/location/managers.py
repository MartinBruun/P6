from django.db.models import Manager

class LocationManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()
    
    
class ServiceManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()