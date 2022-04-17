from django.db.models import Manager

class ElectricityManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()