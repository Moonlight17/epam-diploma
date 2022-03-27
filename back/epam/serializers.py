from epam.models import Country, Stat
from rest_framework import serializers


class CountrySerializer(serializers.ModelSerializer):
    text = serializers.CharField(source='country_code')

    class Meta:
        model = Country
        fields = ['id', 'text', 'pub_date', 'count_data']


class StatSerializer(serializers.ModelSerializer):
    country_name = serializers.CharField(source='country_code')

    class Meta:
        model = Stat
        fields = ['id', 'date_value', 'confirmed', 'deaths', 'stringency_actual', 'stringency', 'stringency_legacy', 'stringency_legacy_disp', 'country_name', 'country_code']
        # fields = '__all__'
