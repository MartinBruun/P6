from django.db import models

from electricity.managers import ElectricityManager

# Create your models here.

class ElectricityBlock(models.Model):
    """
        Represents the electricity in a network inside some given timeframe
    """
    # Fields
    id = models.AutoField(primary_key=True)
    start_time = models.DateTimeField(editable=True)
    end_time = models.DateTimeField(editable=False)
    price = models.DecimalField(max_digits=19, decimal_places=4, default=0)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    ZONES = (
        ("DK1", "West Denmark"),
        ("DK2", "East Denmark")
    )
    zone = models.CharField(
        choices=ZONES,
        max_length=3
    )
    
    # Foreign Keys
    
    # Managers
    objects = ElectricityManager()
    
    def __str__(self):
        return "Electricity price " + str(self.price) + " between " + str(self.start_time) + " and " + str(self.end_time) + " in " + str(self.zone)
    
    class Meta:
        ordering = ['-created']
        db_table = 'electricity_block'
        managed = True
        verbose_name = "electricity_block"
        verbose_name_plural = "electricity_blocks"