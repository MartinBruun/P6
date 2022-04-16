from django.db import models
from django.conf import settings

from security.managers import LoggerManager

# Create your models here.

class Log(models.Model):
    """
        Represents all loggings across the whole program
    """
    # Fields
    id = models.AutoField(primary_key=True)
    content = models.TextField()
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    class SourceChoices(models.TextChoices):
        APP = "APP", "Logs from app"
        BOX = "BOX", "Logs from box"
        WEB = "WEB" "Logs from web"
        MANUAL = "MAN", "Manual logs"
        NONE = "NON", "No given source"
        
    source = models.CharField(
        max_length=32,
        choices=SourceChoices.choices,
        default=SourceChoices.NONE
    )
    
    # Foreign Keys
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE,
        related_name="logs_written"
    )
    
    # Managers
    objects = LoggerManager()
    
    def __str__(self):
        return "Log from " + str(self.source) + ": " + str(self.content)
    
    class Meta:
        ordering = ['-created']
        db_table = 'log'
        managed = True
        verbose_name = "log"
        verbose_name_plural = "logs"