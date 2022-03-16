from django.http import HttpResponse
from rest_framework import viewsets
from epam.models import *
from epam.serializers import CountrySerializer, StatSerializer
from rest_framework import generics

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")


class Country(generics.ListAPIView):
    queryset = Country.objects.all()
    serializer_class = CountrySerializer

class Stat(generics.ListAPIView):
    queryset = Stat.objects.all()
    serializer_class = StatSerializer