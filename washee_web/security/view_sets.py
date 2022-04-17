from rest_framework import viewsets

from security.models import Log
from security.serializers import LogSerializer

class LogViewSet(viewsets.ModelViewSet):
    queryset = Log.objects.all()
    serializer_class = LogSerializer