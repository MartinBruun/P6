from django.db import models
from datetime import timedelta
from django.db.models import Q
from rest_framework.exceptions import ValidationError

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
    end_time = models.DateTimeField(editable=False)
    
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
        self.end_time = self.start_time + timedelta(seconds=self.service.duration_in_sec)
        overlapping_bookings = Booking.objects.filter(machine=self.machine).exclude(
            Q(start_time__lte=self.start_time, end_time__lte=self.start_time) |
            Q(start_time__gte=self.end_time, end_time__gte=self.end_time)
        ).all()
        
        if overlapping_bookings.exists():
            validation_error = "ERROR! The booking clashes with the following bookings:"
            for booking in overlapping_bookings:
                validation_error += ' <' + str(booking.start_time) + ' to ' + str(booking.end_time) +'>'
            raise ValidationError(validation_error)
        else:
            return super(Booking, self).save(*args,**kwargs)
    
    class Meta:
        ordering = ['-created']
        db_table = 'booking'
        managed = True
        verbose_name = "booking"
        verbose_name_plural = "bookings"