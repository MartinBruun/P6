from django.db import models

from electricity.managers import ElectricityManager

# Create your models here.

class ElectricityBlock(models.Model):
    """
        Represents the electricity in a network inside some given timeframe
    """
    GREY_COLOUR_SCORE = -1
    # Fields
    id = models.AutoField(primary_key=True)
    start_time = models.DateTimeField(editable=True)
    end_time = models.DateTimeField(editable=False)
    price = models.DecimalField(max_digits=19, decimal_places=4, default=0)
    green_score = models.IntegerField(default=GREY_COLOUR_SCORE)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    class ZoneChoices(models.TextChoices):
        NONE = "NON", "No given zone"
        WEST_DK = "DK1", "West Denmark"
        EAST_DK = "DK2", "East Denmark"
    
    zone = models.CharField(
        max_length=32,
        choices=ZoneChoices.choices,
        default=ZoneChoices.NONE
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