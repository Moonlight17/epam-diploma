from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('data/', views.data_from_api, name='data'),
    # path('<int:pk>/', views.DetailStat.as_view(), name='detail'),
    path('country/', views.Country_list.as_view(), name='country'),
    path('stat/', views.Stat_list.as_view(), name='stat'),
    path('api/v1/healthz', views.health, name='health')
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)