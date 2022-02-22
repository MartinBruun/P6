from django.db import models


class Location(models.Model):
    name = models.CharField(max_length=64)
    

class Service(models.Model):
    name = models.CharField(max_length=64)
    location = models.ForeignKey(Location, on_delete=models.CASCADE)