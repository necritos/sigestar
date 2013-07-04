from django.conf.urls import patterns, include, url
from django.contrib.auth.views import login, logout

urlpatterns = patterns('appcuentas.views',
                       url(r'^$', 'user_login', name='user_login'),
                       url(r'^login/$', 'user_login', name='user_login'),
                       url(r'^logout/$', 'user_logout', name='user_logout'),
                       url(r'^registrar-personal/$', 'registrar_personal', name='registrar_personal'),
                       url(r'^editar-eliminar-personal/$', 'editar_personal', name='editar_personal'),
                       url(r'^ver-asistencia/$', 'ver_asistencia', name='ver_asistencia'),
                       url(r'^rotar-horario/$', 'rotar_horario', name='rotar_horario'),
                       url(r'^cambiar-horario/$', 'cambiar_horario', name='cambiar_horario'),
                       url(r'^marcar-asistencia/$', 'marcar_asistencia', name='marcar_asistencia'),
                       url(r'^ver-turnos/$', 'ver_turnos', name='ver_turnos'),
                       url(r'^agregar-turno/$', 'agregar_turno', name='agregar_turno'),
                       url(r'^eliminar-turno/$', 'eliminar_turno', name='eliminar_turno'),
                       url(r'^recordar-pass/$', 'recordar_pass', name='recordar_pass'),
                       url(r'^recuperar/$', 'recuperar', name='recuperar'),
                       url(r'^enviar/$', 'enviar_con', name='enviar_con'),
)