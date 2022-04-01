from django.contrib.auth import get_user_model
from rest_framework import serializers

from account.models import Account


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ['id','username', 'email', 'date_joined','last_login','is_active','is_admin', 'is_staff','is_superuser','accounts','locations_owned','machines_owned']
        
        
class AccountSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Account
        fields = ['id', 'name','balance','created','last_updated','users','bookings']