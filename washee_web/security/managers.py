from django.db.models import Manager

class LoggerManager(Manager):
    
    def get_queryset(self):
        return super().get_queryset()