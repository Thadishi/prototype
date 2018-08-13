from django.contrib import admin

# Register your models here.

from .models import User, Nests, DEM

admin.site.register(User)
admin.site.register(Nests)
admin.site.register(DEM)