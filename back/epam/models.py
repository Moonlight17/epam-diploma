from django.db import models

class Country(models.Model):
    country_code = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date added', auto_now_add=True)

    def __str__(self):
        return self.country_code


class Stat(models.Model):
    country_code = models.ForeignKey(Country, on_delete=models.CASCADE)
    date_value = models.DateField()
    confirmed = models.PositiveIntegerField(null=True, blank=True)
    deaths = models.PositiveIntegerField(null=True, blank=True)
    stringency_actual = models.DecimalField(null=True, blank=True, max_digits=7, decimal_places=2)
    stringency = models.DecimalField(null=True, blank=True, max_digits=7, decimal_places=2)
    stringency_legacy = models.DecimalField(null=True, blank=True, max_digits=7, decimal_places=2)
    stringency_legacy_disp = models.DecimalField(null=True, blank=True, max_digits=7, decimal_places=2)

    def __str__(self):
        return self.country_code.country_code + "    " + str(self.date_value)
