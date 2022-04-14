from django.db import models
from django.conf import settings

from location.managers import (
    LocationManager, MachineModelManager, MachineManager, ServiceManager
)

class Location(models.Model):
    """
        Represents an area, where a service made available by a machine can be rented.
        The design is that the Location has some physical machines in it.
        These machines are of a specific model, where each model have different services available.
        
        TODO: Create a function that returns all possible services in the location.
        TODO: Location and MachineModel could possibly be split into two apps
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
        
        
class MachineModel(models.Model):
    """
        Represents a model of a machine which can be manufactored
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=64)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    
    # Foreign Keys
    
    # Managers
    objects = MachineModelManager()
    
    def __str__(self):
        return self.name
    
    class Meta:
        ordering = ['-created']
        db_table = 'machine_model'
        managed = True
        verbose_name = "machine model"
        verbose_name_plural = "machine models"
        

class Machine(models.Model):
    """
        Represents a single physical machine in a location that is possible to be rented.
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=64)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    
    # Foreign Keys
    location = models.ForeignKey(
        Location, 
        on_delete=models.CASCADE,
        related_name="machines"
    )
    model = models.ForeignKey(
        MachineModel,
        on_delete=models.PROTECT,
        related_name="machines"
    )
    owner = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE,
        related_name="machines_owned"
    )
    
    # Managers
    objects = MachineManager()
    
    def __str__(self):
        return self.name
    
    class Meta:
        ordering = ['-created']
        db_table = 'machine'
        managed = True
        verbose_name = "machine"
        verbose_name_plural = "machines"
    

class Service(models.Model):
    """
        Represents a service which can be rented.
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=64)
    duration_in_sec = models.IntegerField()
    price_in_dk = models.DecimalField(max_digits=19,decimal_places=4)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    
    # Foreign Keys
    machine_model = models.ForeignKey(
        MachineModel, 
        on_delete=models.CASCADE,
        related_name="services"
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