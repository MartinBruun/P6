from django.db import models

class Booking(models.Model):
    name = models.CharField(max_length=36)