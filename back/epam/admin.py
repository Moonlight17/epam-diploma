from django.contrib import admin

# Register your models here.
from .models import Country, Stat

admin.site.register(Country)
admin.site.register(Stat)