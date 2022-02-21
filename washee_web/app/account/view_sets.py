from django.contrib.auth.models import User
from rest_framework import viewsets

from account.models import Account
from account.serializers import UserSerializer, AccountSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    

class AccountViewSet(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer