from django.db import models

# Create your models here.
from django.urls import reverse
class User(models.Model):
	user_name = models.CharField(max_length=100)
	first_name = models.CharField(max_length=100)
	last_name = models.CharField(max_length=100)

	organisation = models.CharField(max_length=200)
	reason = models.TextField(max_length=1000)

	def get_absolute_url(self):
		return reverse('author-detail', args=[str(self.id)])

		def __str__(self):
			return f'{self.last_name}, {self.first_name}'



class Nests(models.Model):
	coordinates = models.CharField(max_length=200)

	def get_absolute_url(self):
		return reverse('nest-detail', args=[str(self.id)])

	def __str__(self):
		return self.coordinates

class DEM(models.Model):
	coordinates = models.CharField(max_length=200)
	area = models.CharField(max_length=100)
