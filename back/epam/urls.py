from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('data/', views.data_from_api, name='data'),
    # path('<int:pk>/', views.DetailStat.as_view(), name='detail'),
    path('country/', views.Country_list.as_view(), name='country'),
    path('stat/', views.Stat_list.as_view(), name='stat'),
]