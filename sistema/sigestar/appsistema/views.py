# -*- coding: utf-8 -*-
from appcuentas.models import User, Asistencia
from django.shortcuts import render_to_response, redirect, get_object_or_404, HttpResponse, Http404
from django.template.context import RequestContext
from appsistema.models import Solicitud, Comentario, Tipo, Categoria, Rubro
from django.contrib.auth.decorators import login_required
from appsistema.forms import SolicitudForm
from django.utils.timezone import now
from datetime import timedelta, time
from appsistema.algoritmos import eleccion
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

@login_required(login_url='/login/')
def cola(request):
    if request.user.get_profile().is_empleado():
        sols = list(Solicitud.objects.filter(receptor=request.user).exclude(estado=4))
        sols.sort(key=lambda a: (a.peso, a.creacion))
        sols.reverse()
        solsterminadas = list(Solicitud.objects.filter(estado=4, receptor=request.user).order_by('-creacion'))
        sols = sols + solsterminadas
        dias = {0: 'lunes', 1: 'martes', 2: 'miercoles', 3: 'jueves', 4: 'viernes', 5: 'sabado', 6: 'domingo'}
        diashorario = request.user.get_profile().horario.dias.all()
        enhora = False
        for dia in diashorario:
            if dia.dia.nombre == dias[(now() - timedelta(hours=5)).weekday()]:
                if dia.turno.id == 1:
                    if (now() - timedelta(hours=5)).time() < dia.turno.hora_fin:
                        enhora = True
                        break
                elif dia.turno.id == 2:
                    if dia.turno.hora_ini < (now() - timedelta(hours=5)).time() < dia.turno.hora_fin:
                        enhora = True
                        break
                elif dia.turno.id == 3:
                    if dia.turno.hora_ini < (now() - timedelta(hours=5)).time() < time(23, 59, 59):
                        enhora = True
                        break
            else:
                if dia.turno.id == 1 and dia.dia.codigo == (now() + timedelta(hours=19)).weekday():
                    if dia.turno.hora_ini < (now() - timedelta(hours=5)).time() < time(23, 59, 59):
                        enhora = True
                        break
        if enhora:
            if Asistencia.objects.filter(user=request.user, fecha__day=now().day, fecha__month=now().month,
                fecha__year=now().year):
                asis = 1
            else:
                asis = 0
        else:
            asis = 2
        paginator = Paginator(sols, 10)
        page = request.GET.get('page')
        try:
            sols = paginator.page(page)
        except PageNotAnInteger:
            sols = paginator.page(1)
        except EmptyPage:
            sols = paginator.page(paginator.num_pages)
        return render_to_response("cola_empleado.html", {'sols': sols, 'asis': asis},
            context_instance=RequestContext(request))
    else:
        sols = Solicitud.objects.all()
        filtros = {}
        if 'personal' in request.GET and request.GET.get('personal') != '0':
            sols = sols.filter(receptor__id=request.GET.get('personal'))
            filtros['personal'] = get_object_or_404(User, id=request.GET.get('personal')).get_full_name()
        if 'fecha' in request.GET and request.GET.get('fecha') != 't':
            if request.GET.get('fecha') == 'ly':
                sols = sols.filter(creacion__year=now().year)
                filtros['fecha'] = "ultimo año"
            elif request.GET.get('fecha') == 'lm':
                sols = sols.filter(creacion__month=now().month)
                filtros['fecha'] = "ultimo mes"
            elif request.GET.get('fecha') == 'lw':
                week_day = now().weekday() + 2 if now().weekday() < 6 else 1
                inicio = now() - timedelta(days=week_day - 2)
                fin = now()
                filtros['fecha'] = "ultima semana"
                sols = sols.filter(creacion__range=(inicio, fin))
        if 'tipo' in request.GET and request.GET.get('tipo') != '0':
            sols = sols.filter(tipo__id=request.GET.get('tipo'))
            filtros['tipo'] = get_object_or_404(Tipo, id=request.GET.get('tipo'))
        if 'cat' in request.GET and request.GET.get('cat') != '0':
            sols = sols.filter(categoria__id=request.GET.get('cat'))
            filtros['cat'] = get_object_or_404(Categoria, id=request.GET.get('cat'))
        if 'estado' in request.GET and request.GET.get('estado') != '0':
            sols = sols.filter(estado=request.GET.get('estado'))
            filtros['estado'] = {'1': 'sin empezar', '2': 'en ejecución', '3': 'en pausa', '4': 'terminadas'}.get(
                request.GET.get('estado'))
        if 'esp' in request.GET and request.GET.get('esp') != '0':
            sols = sols.filter(rubro=request.GET.get('esp'))
            filtros['esp'] = get_object_or_404(Rubro, codigo=request.GET.get('esp'))
        emps = User.objects.filter(groups__name='empleados')
        tipos = Tipo.objects.all()
        cats = Categoria.objects.all()
        esps = Rubro.objects.all()
        sols1 = list(sols.exclude(estado=4))
        sols1.sort(key=lambda a: (a.peso, a.creacion))
        sols1.reverse()
        sols2 = list(sols.filter(estado=4).order_by('-creacion'))
        sols = sols1 + sols2
        paginator = Paginator(sols, 10)
        page = request.GET.get('page')
        try:
            sols = paginator.page(page)
        except PageNotAnInteger:
            sols = paginator.page(1)
        except EmptyPage:
            sols = paginator.page(paginator.num_pages)
        return render_to_response("cola_admin.html",
                {'filtros': filtros, 'sols': sols, 'emps': emps, 'tipos': tipos, 'cats': cats, 'esps': esps},
            context_instance=RequestContext(request))


@login_required(login_url='/login/')
def ver_estadisticas(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    return render_to_response("estadisticas.html", {}, context_instance=RequestContext(request))


def accion_correcta(request, accion):
    return render_to_response("accion_correcta.html", {'accion': accion}, context_instance=RequestContext(request))


@login_required(login_url='/login/')
def calificar(request):
    if request.is_ajax():
        if request.method == "POST":
            sol = get_object_or_404(Solicitud, id=request.POST.get('idsol'))
            sol.calificacion = request.POST.get('cal')
            sol.save()
            return HttpResponse("Calificacion hecha.")
    else:
        raise Http404


@login_required(login_url='/login/')
def ver_cola(request):
    if request.is_ajax():
        if request.user.get_profile().is_empleado():
            sols = list(Solicitud.objects.filter(receptor=request.user).exclude(estado=4))
            sols.sort(key=lambda a: (a.peso, a.creacion))
            sols.reverse()
            solsterminadas = Solicitud.objects.filter(receptor=request.user, estado=4).order_by('-creacion')
            solsterminadas = list(solsterminadas)
            sols = sols + solsterminadas
            paginator = Paginator(sols, 10)
            page = request.GET.get('page')
            try:
                sols = paginator.page(page)
            except PageNotAnInteger:
                sols = paginator.page(1)
            except EmptyPage:
                sols = paginator.page(paginator.num_pages)
            emps = None
        else:
            sols = Solicitud.objects.all()
            filtros = {}
            if 'personal' in request.GET and request.GET.get('personal') != '0':
                sols = sols.filter(receptor__id=request.GET.get('personal'))
                filtros['personal'] = get_object_or_404(User, id=request.GET.get('personal')).get_full_name()
            if 'fecha' in request.GET and request.GET.get('fecha') != 't':
                if request.GET.get('fecha') == 'ly':
                    sols = sols.filter(creacion__year=now().year)
                    filtros['fecha'] = "ultimo año"
                elif request.GET.get('fecha') == 'lm':
                    sols = sols.filter(creacion__month=now().month)
                    filtros['fecha'] = "ultimo mes"
                elif request.GET.get('fecha') == 'lw':
                    week_day = now().weekday() + 2 if now().weekday() < 6 else 1
                    inicio = now() - timedelta(days=week_day - 2)
                    fin = now()
                    filtros['fecha'] = "ultima semana"
                    sols = sols.filter(creacion__range=(inicio, fin))
            if 'tipo' in request.GET and request.GET.get('tipo') != '0':
                sols = sols.filter(tipo__id=request.GET.get('tipo'))
                filtros['tipo'] = get_object_or_404(Tipo, id=request.GET.get('tipo'))
            if 'cat' in request.GET and request.GET.get('cat') != '0':
                sols = sols.filter(categoria__id=request.GET.get('cat'))
                filtros['cat'] = get_object_or_404(Categoria, id=request.GET.get('cat'))
            if 'estado' in request.GET and request.GET.get('estado') != '0':
                sols = sols.filter(estado=request.GET.get('estado'))
                filtros['estado'] = {'1': 'sin empezar', '2': 'en ejecución', '3': 'en pausa', '4': 'terminadas'}.get(
                    request.GET.get('estado'))
            if 'esp' in request.GET and request.GET.get('esp') != '0':
                sols = sols.filter(rubro=request.GET.get('esp'))
                filtros['esp'] = get_object_or_404(Rubro, codigo=request.GET.get('esp'))
            sols1 = list(sols.exclude(estado=4))
            sols1.sort(key=lambda a: (a.peso, a.creacion))
            sols1.reverse()
            sols2 = list(sols.filter(estado=4).order_by('-creacion'))
            sols = sols1 + sols2
            paginator = Paginator(sols, 10)
            page = request.GET.get('page')
            try:
                sols = paginator.page(page)
            except PageNotAnInteger:
                sols = paginator.page(1)
            except EmptyPage:
                sols = paginator.page(paginator.num_pages)
            emps = User.objects.filter(groups__name='empleados')
        return render_to_response("ver_cola.html", {'sols': sols, 'emps': emps},
            context_instance=RequestContext(request))
    else:
        raise Http404


@login_required(login_url='/login/')
def crear_solicitud(request):
    try:
        if request.is_ajax():
            if request.method == 'POST':
                solform = SolicitudForm(request.user, request.POST)
                if solform.is_valid():
                    e = eleccion(solform.cleaned_data['tipo'].nombre, solform.cleaned_data['rubro'])
                    s = Solicitud.objects.create(
                        descripcion=solform.cleaned_data['descripcion'],
                        emisor=request.user,
                        receptor=e,
                        tipo=solform.cleaned_data['tipo'],
                        categoria=solform.cleaned_data['categoria'],
                        estado=1
                    )
                    if solform.cleaned_data['categoria'].nombre in ('incidente', 'requerimiento'):
                        s.rubro = solform.cleaned_data['rubro']
                        s.save()
                    return render_to_response("agregada.html", context_instance=RequestContext(request))
            else:
                solform = SolicitudForm(request.user, initial={'emisor': request.user.get_full_name()})
                solform.fields['emisor'].widget.attrs['readonly'] = True
                solform.fields['categoria'].widget.attrs['id'] = 'id_cat'
                solform.fields['categoria'].widget.attrs['onchange'] = 'aparecer_rubro()'
            return render_to_response("crear_solicitud.html", {'solform': solform},
                context_instance=RequestContext(request))
        else:
            print request.is_ajax()
            raise Http404
    except Exception, ex:
        print ex
        raise Http404


@login_required(login_url='/login/')
def detalles_solicitud(request, id_sol):
    if request.is_ajax():
        sol = get_object_or_404(Solicitud, id=id_sol)
        comentarios = Comentario.objects.filter(solicitud_id=id_sol)
        return render_to_response("detalles.html", {'sol': sol, 'comentarios': comentarios},
            context_instance=RequestContext(request))
    else:
        raise Http404


@login_required(login_url='/login/')
def reasignar_solicitud(request):
    if request.is_ajax():
        if 'sol' in request.GET and 'emp' in request.GET:
            sol = Solicitud.objects.get(id=request.GET.get('sol'))
            if sol.estado == 1:
                sol.receptor = User.objects.get(id=request.GET.get('emp'))
                sol.save()
                return HttpResponse("se reasigno correctamente")
        return HttpResponse("no se puede asignar cuando la tarea ya empezó")
    else:
        raise Http404


@login_required(login_url='/login/')
def agregar_comentario(request, id_sol):
    if request.is_ajax() and request.method == "POST" and len(request.POST.get('texto', '')) > 0:
        sol = get_object_or_404(Solicitud, id=id_sol)
        Comentario.objects.create(emisor=request.user, solicitud=sol, texto=request.POST.get('texto'))
        comentarios = Comentario.objects.filter(solicitud__id=id_sol)
        return render_to_response("ver_comentarios.html", {'comentarios': comentarios},
            context_instance=RequestContext(request))
    else:
        raise Http404


@login_required(login_url='/login/')
def aprobar_comentario(request):
    if request.is_ajax() and request.method == "GET" and 'id' in request.GET and 'sol' in request.GET:
        com = get_object_or_404(Comentario, id=request.GET.get('id'))
        com.aprobado = True
        com.save()
        comentarios = Comentario.objects.filter(solicitud__id=request.GET.get('sol'))
        return render_to_response("ver_comentarios.html", {'comentarios': comentarios},
            context_instance=RequestContext(request))
    else:
        raise Http404


@login_required(login_url='/login/')
def iniciar_solicitud(request, id_sol):
    if request.is_ajax():
        sol = get_object_or_404(Solicitud, id=id_sol)
        if sol.estado == 1:
            sol.inicio = now()
        sol.estado = 2
        sol.save()
        return HttpResponse("Tarea {} iniciada!".format(sol))
    else:
        return Http404


@login_required(login_url='/login/')
def pausar_solicitud(request, id_sol):
    if request.is_ajax():
        sol = get_object_or_404(Solicitud, id=id_sol)
        sol.fin = now()
        duracion = sol.fin - sol.inicio
        dias = duracion.days if duracion.days >= 0 else 0
        horas = duracion.seconds / 3600
        minutos = (duracion.seconds % 3600) / 60
        segundos = (duracion.seconds % 360) % 60
        sol.duracion = "dias:{}, horas:{}, minutos:{}, segundos:{}".format(dias, horas, minutos, segundos)
        sol.estado = 3
        sol.save()
        return HttpResponse("Tarea {} pausada!".format(sol))
    else:
        return Http404


@login_required(login_url='/login/')
def terminar_solicitud(request, id_sol):
    if request.is_ajax():
        sol = get_object_or_404(Solicitud, id=id_sol)
        if sol.estado == 2:
            sol.fin = now()
            duracion = sol.fin - sol.inicio
            dias = duracion.days if duracion.days >= 0 else 0
            horas = duracion.seconds / 3600
            minutos = (duracion.seconds % 3600) / 60
            segundos = (duracion.seconds % 360) % 60
            sol.duracion = "{} dias | {} horas | {} minutos | {} segundos".format(dias, horas, minutos, segundos)
        sol.estado = 4
        sol.save()
        return HttpResponse("Tarea {} terminada!".format(sol))
    else:
        return Http404


@login_required(login_url='/login/')
def estadisticas_categoria(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    #sols = sols.filter(estado=1)
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = request.GET.get('anio')
    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[request.GET.get('mes')]
    vector_cat = []
    vector_data = []
    cat = Categoria.objects.all()
    for cc in cat:
        vector_cat.append(str(cc.nombre))
        vector_data.append(len(sols.filter(categoria__id=cc.id)))
    return render_to_response("graficas_estadisticas/categorias.html",
            {'cat': vector_cat, 'data': vector_data, 'mes': mes_actual, 'anio': anio_actual},
        context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadisticas_tipo(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    #sols = sols.filter(estado='1')
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = request.GET.get('anio')
    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[request.GET.get('mes')]
    vector_tipo = []
    tipo = Tipo.objects.all()
    for tt in tipo:
        vector_tipo.append([str(tt.nombre), len(sols.filter(tipo__id=tt.id))])
    return render_to_response("graficas_estadisticas/tipo.html",
            {'tipo': vector_tipo, 'mes': mes_actual, 'anio': anio_actual}, context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadisticas_solicitudes(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    diaMes = {'1': 31, '2': 29, '3': 31, '4': 30, '5': 31, '6': 30, '7': 31, '8': 31, '9': 30, '10': 31, '11': 30,
              '12': 31}
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    #sols = sols.filter(estado='1')
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    num_dias = 31

    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = request.GET.get('anio')

    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[request.GET.get('mes')]
        num_dias = diaMes[request.GET.get('mes')]

    vector_data = []
    for x in xrange(1, num_dias + 1):
        vector_data.append(len(sols.filter(creacion__day=x)))

    return render_to_response("graficas_estadisticas/numero_solicitudes_mes.html",
            {'data': vector_data, 'num_dias': num_dias, 'mes': mes_actual, 'anio': anio_actual},
        context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadistica_estado(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    personal = 'todos los empleado'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = request.GET.get('anio')

    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[request.GET.get('mes')]

    if 'personal' in request.GET and request.GET.get('personal') != '0':
        sols = sols.filter(receptor__id=request.GET.get('personal'))
        personal = get_object_or_404(User, id=request.GET.get('personal')).get_full_name()

    estados = {1: 'sin empezar', 2: 'en ejecucion', 3: 'en pausa', 4: 'terminadas'}
    data = []
    for x in xrange(1, 5):
        data.append([estados[x], len(sols.filter(estado=x))])
    emp = User.objects.filter(groups__name='empleados')
    return render_to_response("graficas_estadisticas/empleado.html",
            {'data': data, 'mes': mes_actual, 'anio': anio_actual, 'personal': personal, 'emp': emp},
        context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadistica_incidente(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    sols = sols.filter(categoria__nombre='incidente')
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = request.GET.get('anio')
    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[request.GET.get('mes')]
    data = [['critico', len(sols.filter(calificacion='critico'))], ['alto', len(sols.filter(calificacion='alto'))],
        ['medio', len(sols.filter(calificacion='medio'))],
        ['bajo', len(sols.filter(calificacion='bajo'))]]
    return render_to_response("graficas_estadisticas/incidente.html",
            {'data': data, 'mes': mes_actual, 'anio': anio_actual}, context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadistica_feed(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    sols = sols.filter(categoria__nombre='incidente')
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = str(request.GET.get('anio'))

    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[str(request.GET.get('mes'))]
    sols = sols.filter(estado=4)
    fb = 0
    nfb = 0
    for ss in sols:
        comentarios = Comentario.objects.filter(solicitud__id=ss.id)
        comentarios = comentarios.filter(emisor__groups__name='administradores')
        if len(comentarios.filter(fecha__gt=ss.fin)) > 0:
            fb += 1
        else:
            nfb += 1
    data = [['feedback', fb], ['no feedback', nfb]]

    return render_to_response("graficas_estadisticas/feedback.html",
            {'data': data, 'mes': mes_actual, 'anio': anio_actual}, context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadistica_empleado(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    mes_actual = 'todos los meses'
    anio_actual = 'todos los años'
    personal = 'todos los empleado'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = str(request.GET.get('anio'))

    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[str(request.GET.get('mes'))]

    if 'personal' in request.GET and request.GET.get('personal') != '0':
        sols = sols.filter(receptor__id=request.GET.get('personal'))
        personal = get_object_or_404(User, id=request.GET.get('personal')).get_full_name()

    estados = {1: 'sin empezar', 2: 'en ejecucion', 3: 'en pausa', 4: 'terminadas'}
    data = []
    for x in xrange(1, 5):
        data.append([estados[x], len(sols.filter(estado=x))])
    emp = User.objects.filter(groups__name='empleados')
    return render_to_response("graficas_estadisticas/empleado.html",
            {'data': data, 'mes': mes_actual, 'anio': anio_actual, 'personal': personal, 'emp': emp},
        context_instance=RequestContext(request))


@login_required(login_url='/login/')
def estadistica_turnos(request):
    if not request.user.get_profile().is_super():
        return redirect('/login')
    meses = {'1': 'enero', '2': 'febrero', '3': 'marzo', '4': 'abril', '5': 'mayo', '6': 'junio', '7': 'julio',
             '8': 'agosto', '9': 'setiembre', '10': 'octubre', '11': 'noviembre', '12': 'diciembre'}
    sols = Solicitud.objects.all()
    mes_actual = 'todos los meses'
    dia = 'todos los dias'
    anio_actual = 'todos los años'
    if 'anio' in request.GET and request.GET.get('anio') != '0':
        sols = sols.filter(creacion__year=request.GET.get('anio'))
        anio_actual = str(request.GET.get('anio'))
    if 'mes' in request.GET and request.GET.get('mes') != '0':
        sols = sols.filter(creacion__month=request.GET.get('mes'))
        mes_actual = meses[str(request.GET.get('mes'))]
    if 'dia' in request.GET and request.GET.get('dia') != '0':
        sols = sols.filter(creacion__day=request.GET.get('dia'))
        dia = str(request.GET.get('dia'))
    m = 0
    t = 0
    n = 0
    for ss in sols:
        if time(7, 30, 0) < ss.creacion.time() < time(17, 30, 0):
            m += 1
        else:
            if time(17, 30, 0) < ss.creacion.time() < time(23, 59, 59):
                t += 1
            else:
                n += 1
    data = [["maniana", m], ['tarde', t], ['noche', n]]
    return render_to_response("graficas_estadisticas/dia.html",
            {'data': data, 'mes': mes_actual, 'anio': anio_actual, 'dia': dia, 'rango': range(1, 32)},
        context_instance=RequestContext(request))