from rest_framework import serializers

from security.models import Log

class LogSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Log
        fields = ['id', 'content','source','created','last_updated','user']