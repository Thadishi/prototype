from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.staticfiles.templatetags.staticfiles import static
from django.template import Context, loader
import os.path

# Create your views here.

from .models import User, Nests, DEM

def index(request):

	return render(request, 'index.html')

def map(request):
	template = loader.get_template("map.html")
	return HttpResponse(template.render())