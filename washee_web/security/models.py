from django.db import models

# Create your models here.

class Logger(models.Model):
    """
        Represents all loggings across the whole program
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=64)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    source = (
        ("APP", "Logs from app"),
        ("BOX", "Logs from box"),
        ("WEB" "Logs from web"),
        ("MAN", "Manual logs")
    )
    
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