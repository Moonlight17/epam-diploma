from unicodedata import decimal

import requests, json, datetime
from django.http import HttpResponse, JsonResponse
from rest_framework import viewsets
from epam.models import *
from epam.serializers import CountrySerializer, StatSerializer
from rest_framework import generics
from django.shortcuts import get_list_or_404, get_object_or_404

def index(request):
    print('INDEX')
    return HttpResponse("Hello, world. You're at the polls index.")


class Country_list(generics.ListAPIView):
    queryset = Country.objects.all()
    serializer_class = CountrySerializer

class Country_list(generics.ListAPIView):
    queryset = Country.objects.all()
    serializer_class = CountrySerializer


class Stat_list(generics.ListAPIView):
    queryset = Stat.objects.all()
    serializer_class = StatSerializer

def data_from_api(request):
    response = requests.get('https://covidtrackerapi.bsg.ox.ac.uk/api/v2/stringency/date-range/2022-03-10/2022-04-12')
    # print(response.json())
    code = Country.objects.get(country_code__exact='USA')
    # print(code)
    # data_test = Stat.objects.get(country_code__exact=code)
    # print(data_test)
    # data = response.json().loads()
    data = response.json()
    # print(data['data'])
    result_data = data['data']
    for country in data['countries']:
        obj, created = Country.objects.get_or_create(
            country_code=country,
        )
    for date in data['data']:
        for countries in data['data'][date]:
            cou = Country.objects.get(country_code=countries)
            # print("---",data['data'][date][countries],"---")
            date_cou = datetime.datetime.strptime(data['data'][date][countries]['date_value'], "%Y-%m-%d")
            obj, created = Stat.objects.get_or_create(
                country_code=cou,
                date_value=date_cou,
            )
            if created:
                obj.confirmed = data['data'][date][countries]['confirmed']
                obj.deaths = data['data'][date][countries]['deaths']
                obj.stringency_actual = data['data'][date][countries]['stringency_actual']
                obj.stringency = data['data'][date][countries]['stringency']
                obj.stringency_legacy = data['data'][date][countries]['stringency_legacy']
                obj.stringency_legacy_disp = data['data'][date][countries]['stringency_legacy_disp']
                obj.save()

    return HttpResponse(200)
