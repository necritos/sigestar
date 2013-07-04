from django.contrib.auth.models import User
from appsistema.models import Solicitud
from django.utils.timezone import now
from datetime import timedelta, time

def eleccion(solicitud_nombre, solicitud_rubro):
    e = None
    l = []
    p = None
    t = User.objects.filter(groups__name='empleados')
    restar = set()
    dias = {0: 'lunes', 1: 'martes', 2: 'miercoles', 3: 'jueves', 4: 'viernes', 5: 'sabado', 6: 'domingo'}
    for empleado in t:
        acerto = False
        try:
            diashorario = empleado.get_profile().horario.dias.all()
        except Exception,ex:
            restar.add(empleado)
            continue
        for dia in diashorario:
            if dia.dia.nombre == dias[(now() - timedelta(hours=5)).weekday()]:
                if dia.turno.id == 1:
                    if (now() - timedelta(hours=5)).time() < dia.turno.hora_fin:
                        acerto = True
                        break
                elif dia.turno.id == 2:
                    if dia.turno.hora_ini < (now() - timedelta(hours=5)).time() < dia.turno.hora_fin:
                        acerto = True
                        break
                elif dia.turno.id == 3:
                    if dia.turno.hora_ini < (now() - timedelta(hours=5)).time() < time(23, 59, 59):
                        acerto = True
                        break
            else:
                if dia.turno.id == 1 and dia.dia.codigo == (now() + timedelta(hours=19)).weekday():
                    if dia.turno.hora_ini < (now() - timedelta(hours=5)).time() < time(23, 59, 59):
                        acerto = True
                        break
        if not acerto:
            restar.add(empleado)
    if solicitud_nombre == 'base de datos':
        for emp in t:
            if emp.get_profile().dba:
                l.append(emp)
        for emp in l:
            if e is None:
                e = emp
                p = peso_solicitudes(e)
            else:
                aux = peso_solicitudes(emp)
                if p > aux:
                    e = emp
                    p = aux
    else:
        t = set(t) - restar
        #dba y plataforma
        if solicitud_nombre != 'plataforma':
            k = []
            for emp in t:
                if not emp.get_profile().dba:
                    k.append(emp)
            t = k
        for emp in t:
            if not l:
                p = peso_solicitudes(emp)
                l.append(emp)
            else:
                aux = peso_solicitudes(emp)
                if p == aux:
                    l.append(emp)
                elif p > aux:
                    l = [emp]
                    p = aux

        if solicitud_nombre == 'conectividad':
            #ver si hay especialista
            for emp in l:
                if emp.get_profile().especialidad.filter(nombre=solicitud_rubro):
                    e = emp
                    break

        if e is None:
            for emp in l:
                e = emp
                break
    return e


def peso_solicitudes(e):
    cont = 0
    l = Solicitud.objects.filter(receptor=e).exclude(estado=4)
    for s in l:
        cont += s.peso
    return cont



