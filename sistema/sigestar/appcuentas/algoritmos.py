from datetime import timedelta
from datetime import *
import threading
from appcuentas.models import Asistencia
from django.utils.timezone import now
from models import Horario, User, Asistencia
from appcuentas.models import Perfil, Dia, Turno, Campo


def registrar_inasistencias(fecha_actual, u):
    ult_asi = fecha_actual
    if u.get_profile().horario.fecha_crea:
        ult_asi = u.get_profile().horario.fecha_crea
    else:
        return 1
    if Asistencia.objects.filter(user=u):
        if Asistencia.objects.filter(user=u).order_by('-fecha')[0]:
            ult_asi_aux = Asistencia.objects.filter(user=u).order_by('-fecha')[0]
            if ult_asi_aux.turno_ini > ult_asi:
                ult_asi = ult_asi_aux.turno_ini
    fecha_reco = rango_fechas(fecha_actual, ult_asi)
    for ff in fecha_reco:
        sem = dia_semana(ff.day, ff.month, ff.year)
        if u.get_profile().horario.dias.filter(dia__codigo=sem):
            Asistencia.objects.create(user=u, fecha=datetime(ff.year, ff.month, ff.day), valor=False,
                                      turno_ini=datetime(ff.year, ff.month, ff.day))
    dia_actual_inasistencia(fecha_actual, u)


def dia_actual_inasistencia(fecha_dia, u):
    if Asistencia.objects.filter(user=u):
        if Asistencia.objects.filter(user=u).order_by('-fecha')[0]:
            ult_asi_aux = Asistencia.objects.filter(user=u).order_by('-fecha')[0]
            if ult_asi_aux.turno_ini.year == fecha_dia.year and ult_asi_aux.turno_ini.month == fecha_dia.month and ult_asi_aux.turno_ini.day == fecha_dia.day:
                return 1
    sem = dia_semana(fecha_dia.day, fecha_dia.month, fecha_dia.year)
    if u.get_profile().horario.dias.filter(dia__codigo=sem):
        try:
            campo = u.get_profile().horario.dias.get(dia__codigo=sem)
            if campo:
                ini = campo.turno.hora_ini
                if ini.hour == 23:
                    if fecha_dia.hour > 7:
                        Asistencia.objects.create(user=u,
                                                  fecha=datetime(fecha_dia.year, fecha_dia.month, fecha_dia.day),
                                                  valor=False,
                                                  turno_ini=datetime(fecha_dia.year, fecha_dia.month, fecha_dia.day))
                if ini.hour == 7:
                    if (fecha_dia.hour > 17 or ( fecha_dia.hour == 17 and fecha_dia.minute > 30 )):
                        Asistencia.objects.create(user=u,
                                                  fecha=datetime(fecha_dia.year, fecha_dia.month, fecha_dia.day),
                                                  valor=False,
                                                  turno_ini=datetime(fecha_dia.year, fecha_dia.month, fecha_dia.day))
        except Exception:
            print Exception


def dia_semana(D, M, A):
    if esBisiesto(A):
        cad = [0, 3, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6]
    else:
        cad = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5]
    d = ((A - 1) % 7 + (((A - 1) / 4) - 3 * ((A - 1) / 100 + 1) / 4) % 7 + cad[M - 1] + D % 7) % 7
    return (d + 6) % 7


def rango_fechas(end_date, start_date):
    day_count = (end_date - start_date).days - 1
    if day_count < 1:
        return []
    else:
        ss = [d for d in (start_date + timedelta(n + 1) for n in range(day_count)) if d <= end_date]
        return ss


def esBisiesto(A):
    if A % 4 == 0:
        if A % 100 == 0 and A % 400 != 0:
            return 0
        else:
            return 1
    else:
        return 0