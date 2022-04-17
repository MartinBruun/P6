from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

from account.models import Account


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ['id','username', 'email', 'date_joined','last_login','is_active','is_admin', 'is_staff','is_superuser','accounts','locations_owned','machines_owned']
        validators = [
            UniqueTogetherValidator(
                queryset=get_user_model().objects.all(),
                fields=['username','email']
            )
        ]
        
class AccountSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Account
        fields = ['id', 'name','balance','created','last_updated','owners','bookings']