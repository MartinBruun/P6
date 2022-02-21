from django.db import models

# MIS Martin: Create Custom User Model!

class Account(models.Model):
    name = models.CharField(max_length=36)