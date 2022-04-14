from django.db import models
from datetime import timedelta

from location.models import Machine, Service
from account.models import Account
from booking.managers import (
    BookingManager
)

class Booking(models.Model):    
    """
        Represents a single booking, with a chosen start_time, where the booking was made at a specific time (created)
        It is setup so that it is possible to change this booking.
        
        TODO: Presently, the database does not make any validation if there happens to be a double booking.
    """
    
    # Fields
    id = models.AutoField(primary_key=True)
    start_time = models.DateTimeField(editable=True)
    end_time = models.DateTimeField(editable=True)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    
    # Foreign Keys
    machine = models.ForeignKey(
        Machine, 
        on_delete=models.CASCADE,
        related_name="bookings"
    )
    service = models.ForeignKey(
        Service,
        on_delete=models.CASCADE,
        related_name="bookings",
        blank=True,
        null=True
    )
    account = models.ForeignKey(
        Account, 
        on_delete=models.CASCADE,
        related_name="bookings"
    )
    
    # Managers
    objects = BookingManager()
    
    def __str__(self):
        return "Booking made by " + self.account.name + " at " + str(self.created)
    
    def save(self, *args, **kwargs):
        start = self.start_time.date_time()
        end = start + timedelta(seconds=9000)
        overlapping_bookings = Booking.objects.filter(start_time__range=[start, end]).all()
        
        print(overlapping_bookings)
        
        
        return super(Booking, self).save(*args,**kwargs)
    
    class Meta:
        ordering = ['-created']
        db_table = 'booking'
        managed = True
        verbose_name = "booking"
        verbose_name_plural = "bookings"