from django.db import models
import pytz
from datetime import datetime, timedelta
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
    """
    
    # Fields
    id = models.AutoField(primary_key=True)
    start_time = models.DateTimeField(editable=True)
    end_time = models.DateTimeField(editable=False)
    active = models.BooleanField(default=True)
    activated = models.BooleanField(default=False)
    
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
        pre_fix = ""
        if self.active:
            if self.activated:
                pre_fix = "(activated)"
            elif self.end_time >= datetime.now(pytz.UTC):
                pre_fix = "(active)"
            else:
                pre_fix = "(skipped)"
        else:
            pre_fix = "(deleted)"
                
        return pre_fix + " Booking from " + str(self.start_time) + " to " + str(self.end_time) + " made by " + str(self.account.name)
    
    def save(self, *args, **kwargs):
        self.end_time = self.start_time + timedelta(seconds=self.service.duration_in_sec)
        overlapping_bookings = Booking.objects.filter(machine=self.machine).exclude(id=self.id).exclude(active=False).exclude(
            Q(start_time__lte=self.start_time, end_time__lte=self.start_time) |
            Q(start_time__gte=self.end_time, end_time__gte=self.end_time)
        ).all()
        
        if overlapping_bookings.exists():
            validation_error = "ERROR! The booking clashes with the following bookings:"
            for booking in overlapping_bookings:
                validation_error += ' <' + str(booking.start_time) + ' to ' + str(booking.end_time) +'>'
            raise ValidationError(validation_error)
        else:
            if self.pk is None:
                self.account.balance -= self.service.price_in_dk
                self.account.save()
            return super(Booking, self).save(*args,**kwargs)
        
    def delete(self):
        if self.activated or not self.active:
            raise ValidationError("Can't delete inactive or activated bookings!")
        self.account.balance += self.service.price_in_dk
        self.account.save()
        self.active = False
        return super(Booking, self).save()
    
    class Meta:
        ordering = ['-created']
        db_table = 'booking'
        managed = True
        verbose_name = "booking"
        verbose_name_plural = "bookings"