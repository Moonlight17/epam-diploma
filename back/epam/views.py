import requests, datetime, json
from django.http import HttpResponse, JsonResponse
from epam.models import *
from epam.serializers import CountrySerializer, StatSerializer
from rest_framework.response import Response
from rest_framework import generics

def index(request):
    print('INDEX')
    return HttpResponse("Hello, world. You're at the polls index.")


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
    response = requests.get('https://covidtrackerapi.bsg.ox.ac.uk/api/v2/stringency/date-range/2022-03-10/2022-04-12')
    data = response.json()
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
