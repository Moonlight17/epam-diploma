from epam.models import Country, Stat
from rest_framework import serializers


class CountrySerializer(serializers.ModelSerializer):
    class Meta:
        model = Country
        fields = '__all__'


class StatSerializer(serializers.ModelSerializer):
    country_name = serializers.CharField(source='country_code')
    class Meta:
        model = Stat
        fields = ['date_value', 'confirmed', 'deaths', 'stringency_actual', 'stringency', 'stringency_legacy', 'stringency_legacy_disp', 'country_name', 'country_code']
