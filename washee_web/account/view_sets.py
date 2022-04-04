from django.contrib.auth import get_user_model
from rest_framework import viewsets


from account.models import Account
from account.serializers import UserSerializer, AccountSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer
    

class AccountViewSet(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer