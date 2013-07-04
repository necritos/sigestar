from django.contrib import admin
from appsistema.models import Categoria, Solicitud, Tipo, Rubro

admin.site.register(Categoria)
admin.site.register(Tipo)
admin.site.register(Solicitud)
admin.site.register(Rubro)