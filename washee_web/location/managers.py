from django.db.models import Manager

class LocationManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()
    
    
class MachineManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()
    

class MachineModelManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()
    
    
class ServiceManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()