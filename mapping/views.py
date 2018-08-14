from django.shortcuts import render

# Create your views here.

from .models import User, Nests, DEM

def index(request):

	num_nests = Nests.objects.all().count()

	context = {
		'num_nests': num_nests
	}

	return render(request, 'index.html', context=context)
def mapRender(request):
	mapbox_access_token = 'pk.eyJ1IjoidGhhZGlzaGkiLCJhIjoiY2prdGVpZ282MDU5bDNrbGplZjdkajcwMyJ9.6j75DNDrM9M_76hSPBZryQ'

	
	return render(request, 'mapRender.html', {
		'mapbox_access_token': mapbox_access_token
	})