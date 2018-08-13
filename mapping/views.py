from django.shortcuts import render

# Create your views here.

from .models import User, Nests, DEM

def index(request):

	num_nests = Nests.objects.all().count()

	context = {
		'num_nests': num_nests
	}

	return render(request, 'index.html', context=context)