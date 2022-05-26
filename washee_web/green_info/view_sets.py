from rest_framework import viewsets

from green_info.models import ElectricityBlock
from green_info.serializers import ElectricityBlockSerializer


class ElectricityBlockViewSet(viewsets.ModelViewSet):
    queryset = ElectricityBlock.objects.all()
    serializer_class = ElectricityBlockSerializer
