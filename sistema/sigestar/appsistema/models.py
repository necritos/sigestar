from django.db import models
from django.contrib.auth.models import User

#Rubro
class Rubro(models.Model):
    codigo = models.SmallIntegerField(primary_key=True)
    nombre = models.CharField(max_length=100)

    def __unicode__(self):
        return self.nombre

#Tipo de solicitud (tabla maestra)
class Tipo(models.Model):
    nombre = models.CharField(max_length=15)

    def __unicode__(self):
        return self.nombre

#Categoria de solicitud (tabla maestra)
class Categoria(models.Model):
    nombre = models.CharField(max_length=20)

    def __unicode__(self):
        return self.nombre

#Solicitud que puede emitir un administrador y tomar un emepleado
class Solicitud(models.Model):
    creacion = models.DateTimeField(auto_now_add=True)
    inicio = models.DateTimeField(null=True, blank=True)
    fin = models.DateTimeField(null=True, blank=True)
    duracion = models.CharField(max_length=100, null=True, blank=True)
    emisor = models.ForeignKey(User, related_name="sol_enviadas")
    receptor = models.ForeignKey(User, related_name="sol_recibidas")
    descripcion = models.TextField()
    tipo = models.ForeignKey(Tipo)
    categoria = models.ForeignKey(Categoria)
    rubro = models.ForeignKey(Rubro, blank=True, null=True)
    estado = models.SmallIntegerField()
    calificacion = models.CharField(max_length=10, null=True, blank=True)

    def __unicode__(self):
        return unicode(self.tipo) + " | " + unicode(self.categoria)

    #retorna el peso de una solicitud en base a su tipo y categoria, se accede como propiedad s.peso
    @property
    def peso(self):
        y = {'incidente': 1000, 'requerimiento': 100, 'trabajo programado': 10, 'trabajo asignado': 1}.get(
            self.categoria.nombre)
        return y

#Comentarios en las solicitudes
class Comentario(models.Model):
    emisor = models.ForeignKey(User, related_name='miscomentarios')
    solicitud = models.ForeignKey(Solicitud, related_name='comentarios')
    texto = models.TextField()
    fecha = models.DateTimeField(auto_now_add=True)
    aprobado = models.BooleanField(default=False)

    def __unicode__(self):
        return self.texto
