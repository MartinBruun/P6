from rest_framework import viewsets

from electricity.models import ElectricityBlock
from electricity.serializers import ElectricityBlockSerializer

class ElectricityBlockViewSet(viewsets.ModelViewSet):
    queryset = ElectricityBlock.objects.all()
    serializer_class = ElectricityBlockSerializer