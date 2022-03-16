from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('country/', views.Country.as_view(), name='country'),
    path('stat/', views.Stat.as_view(), name='stat'),
]