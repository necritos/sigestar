from django.contrib import admin
from appcuentas.models import Horario, Perfil, Dia, Asistencia, Turno

admin.site.register(Horario)
admin.site.register(Perfil)
admin.site.register(Dia)
admin.site.register(Asistencia)
admin.site.register(Turno)