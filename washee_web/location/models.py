from django.db import models
from django.conf import settings
from django.contrib.auth import get_user_model

from location.managers import (
    LocationManager, ServiceManager
)

class Location(models.Model):
    """
        Represents an area where some services can be rented.
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=64)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    
    # Foreign Keys
    owner = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE,
        related_name="locations_owned"
    )
    
    # Managers
    objects = LocationManager()
    
    def __str__(self):
        return self.name
    
    class Meta:
        ordering = ['-created']
        db_table = 'location'
        managed = True
        verbose_name = "location"
        verbose_name_plural = "locations"
    

class Service(models.Model):
    """
        Represents a service which can be rented.
        The specific type can be seen in SERVICE_TYPE (there are only _MACHINE services right now)
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=64)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    SERVICE_TYPE = (
        ("WASH_MACHINE", "a rentable washing machine"),
        ("DRY_MACHINE", "a rentable drying machine")
    )
    service_type = models.CharField(
        choices=SERVICE_TYPE,
        max_length=16,
        verbose_name="type of service"
    )
    
    # Foreign Keys
    location = models.ForeignKey(
        Location, 
        on_delete=models.CASCADE,
        related_name="services"
    )
    owner = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE,
        related_name="services_owned"
    )
    
    # Managers
    objects = ServiceManager()
    
    def __str__(self):
        return self.name
    
    class Meta:
        ordering = ['-created']
        db_table = 'service'
        managed = True
        verbose_name = "service"
        verbose_name_plural = "services"