from django.db import models
from django.contrib.auth.models import User
from appsistema.models import Rubro

#Horario
class Horario(models.Model):
    fecha_crea = models.DateTimeField(auto_now_add=True)

#Turno H:m:s - H:m:s para aun determinado dia
class Turno(models.Model):
    hora_ini = models.TimeField()
    hora_fin = models.TimeField()

    def __unicode__(self):
        return "{} - {}".format(self.hora_ini, self.hora_fin)

#Tabla maestra de los dias de la semana, empezando por Lunes = 0
class Dia(models.Model):
    codigo = models.SmallIntegerField(primary_key=True)
    nombre = models.CharField(max_length=30)

    def __unicode__(self):
        return self.nombre

#Dia de la semana de un Horario
class Campo(models.Model):
    dia = models.ForeignKey(Dia)
    turno = models.ForeignKey(Turno)
    horario = models.ForeignKey(Horario, related_name='dias')

    def __unicode__(self):
        return "{}: {} - {}".format(self.dia.nombre, self.turno.hora_ini, self.turno.hora_fin)

#Perfil de usuario del sistema
class Perfil(models.Model):
    user = models.OneToOneField(User)
    dni = models.CharField(max_length=8)
    direccion = models.TextField(null=True, blank=True)
    telefono = models.CharField(max_length=9, null=True, blank=True)
    especialidad = models.ManyToManyField(Rubro, null=True, blank=True)
    empresa = models.CharField(max_length=10)
    horario = models.ForeignKey(Horario, null=True, blank=True)
    dba = models.BooleanField(default=False)

    def __unicode__(self):
        return self.user.__unicode__()

    def is_empleado(self):
        return self.user in User.objects.filter(groups__name='empleados')

    def is_admin(self):
        return self.user in User.objects.filter(groups__name='administradores')

    def is_super(self):
        return self.user in User.objects.filter(groups__name='super')

#Asistencia de un empleado
class Asistencia(models.Model):
    user = models.ForeignKey(User)
    fecha = models.DateTimeField()
    valor = models.BooleanField()
    turno_ini = models.DateTimeField(null=True, blank=True)

    def __unicode__(self):
        return "asistio" if self.valor else "no asistio"