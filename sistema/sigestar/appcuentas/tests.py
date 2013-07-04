"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""
from django.contrib.auth import authenticate
from django.contrib.auth.models import User, Group

from django.test import TestCase
from appcuentas.models import Dia, Turno, Perfil, Horario, Campo
from datetime import time
from appsistema.algoritmos import eleccion
from appsistema.models import Rubro, Tipo


class AutenticacionTest(TestCase):
    def setUp(self):
        User.objects.create_user(username='admin', password='admin', email='admin@sigestar.com')

    def test_all_correct(self):
        res = authenticate(username='admin', password='admin')
        self.assertIsNotNone(res)

    def test_username_incorrect(self):
        res = authenticate(username='456', password='admin')
        self.assertIsNone(res)

    def test_password_incorrect(self):
        res = authenticate(username='admin', password='545')
        self.assertIsNone(res)

    def test_all_incorrect(self):
        res = authenticate(username='admin1', password='admin1')
        self.assertIsNone(res)


class ReparticionTareasTest(TestCase):
    def setUp(self):
        admins = Group.objects.create(name='administradores')
        empleados = Group.objects.create(name='empleados')

        r = Rubro.objects.create(codigo=4, nombre='Seguridad')
        Tipo.objects.create(nombre='conectividad')
        jueves = Dia.objects.create(codigo=3, nombre='jueves')
        Turno.objects.create(hora_ini=time(23, 0, 0), hora_fin=time(8, 0, 0))
        Turno.objects.create(hora_ini=time(7, 30, 0), hora_fin=time(17, 0, 0))
        turno = Turno.objects.create(hora_ini=time(14, 0, 0), hora_fin=time(0, 0, 0))

        admin = User.objects.create_user(username='admin', password='admin', email='admin@sigestar.com')
        admin.groups.add(admins)
        Perfil.objects.create(user=admin, dni='78945612', empresa='telefonica')

        self.e1 = User.objects.create_user(username='empleado1', password='empleado1', email='empleado1@sigestar.com')
        self.e1.groups.add(empleados)
        p1 = Perfil.objects.create(user=self.e1, dni='12345678', empresa='solrac', dba=True)
        h1 = Horario.objects.create()
        Campo.objects.create(dia=jueves, turno=turno, horario=h1)
        p1.horario = h1
        p1.save()

        self.e2 = User.objects.create_user(username='empleado2', password='empleado2', email='empleado2@sigestar.com')
        self.e2.groups.add(empleados)
        p2 = Perfil.objects.create(user=self.e2, dni='78878745', empresa='solrac')
        h2 = Horario.objects.create()
        Campo.objects.create(dia=jueves, turno=turno, horario=h2)
        p2.horario = h2
        p2.especialidad.add(r)
        p2.save()

    def test_tarea_bd(self):
        e = eleccion('base de datos', None)
        self.assertEqual(e, self.e1)

    def test_tarea_seguridad(self):
        e = eleccion('conectividad', 'Seguridad')
        self.assertEqual(e, self.e2)