from rest_framework import serializers

from electricity.models import ElectricityBlock

class ElectricityBlockSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = ElectricityBlock
        fields = ['id', 'start_time','end_time','price', 'green_score', 'created','last_updated','zone']