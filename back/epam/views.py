import requests, datetime, json, datetime
from django.http import HttpResponse
from epam.models import *
from epam.serializers import CountrySerializer, StatSerializer
from rest_framework.response import Response
from rest_framework import generics
from django.shortcuts import render

def index(request):
    print('INDEX')
    return render(request, 'index.html')


class Country_list(generics.ListAPIView):
    queryset = Country.objects.all()
    serializer_class = CountrySerializer

    # def get(self, request):
    #     queryset = Country.objects.all()
    #     return Response()

# class Country_list(generics.ListAPIView):
#     queryset = Country.objects.all()
#     serializer_class = CountrySerializer
#

class Stat_list(generics.ListAPIView):
    queryset = Stat.objects.all()
    serializer_class = StatSerializer

    def post(self, request):
        data = json.loads(request.body)
        need = data['data']
        query = {}
        inner_qs = Country.objects.filter(country_code__in=need)
        for country in inner_qs:
            data = Stat.objects.filter(country_code__exact=country)
            serializer = StatSerializer(data, many=True)

            query[country.country_code] = serializer.data
        return Response(query)

def data_from_api(request):
    start_date = str(datetime.datetime.now().year) + '#01#01'
    start_date = start_date.replace('#','-')
    cur_date = str(datetime.datetime.now().year) + '#' + str(datetime.datetime.now().month) + '#' + str(datetime.datetime.now().day)
    cur_date = cur_date.replace('#','-')
    list_countries = ['RUS', 'USA', 'KAZ', 'DEU', 'CAN', 'CZE', 'ISR', 'JPN', 'ITA', 'SWE']
    response = requests.get('https://covidtrackerapi.bsg.ox.ac.uk/api/v2/stringency/date-range/' + start_date+ '/' + cur_date)
    data = response.json()
    for countries in list_countries:
        cou, created = Country.objects.get_or_create(country_code=countries)
    countries = ''
    for date in data['data']:
        for countries in data['data'][date]:
            if countries in list_countries:
                cou = Country.objects.get(country_code=countries)
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
            else: pass
    clist = Country.objects.all()
    for c in clist:
        c.count_data = Stat.objects.filter(country_code=c).count()
        c.save()
    return HttpResponse(200)
