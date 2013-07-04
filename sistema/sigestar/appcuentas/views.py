# -*- coding: utf-8 -*-
# Create your views here.
from django.core.urlresolvers import reverse, reverse_lazy
from django.core.mail.message import EmailMultiAlternatives
from django.shortcuts import render_to_response, redirect, HttpResponse, Http404, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.template.context import RequestContext
from django.utils.timezone import now
from django.contrib.auth.models import Group
from django.core.mail import send_mail

from datetime import timedelta, time, datetime
from appcuentas.algoritmos import registrar_inasistencias
from appcuentas.models import Perfil, Dia, Turno, Campo
from appcuentas.forms import RegistrarPersonal, RegistrarHorario
from models import Horario, User, Asistencia


pin = {}
e = None


def user_login(request):
    if request.user.is_authenticated():
        return redirect(reverse('cola'))
    error = None
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                try:
                    if user.get_profile().is_empleado() and user.get_profile().horario is None:
                        logout(request)
                        error = "No se puede loguear porque no tiene un horario definido aun"
                    else:
                        return redirect(reverse('cola'))
                except Exception:
                    error = "No se detecta el tipo de cuenta, asegurate de tener un perfil"
        else:
            error = 'Usuario o contraseña incorrecto. Por favor intente de nuevo'
    return render_to_response('login.html', {'error': error}, context_instance=RequestContext(request))


def user_logout(request):
    logout(request)
    return redirect(reverse('user_login'))


def recordar_pass(request):
    if 'email' in request.GET:
        email = request.GET.get('email')
        if email and User.objects.filter(email=email):
            pinuser = User.objects.make_random_password(length=20)
            iduser = User.objects.get(email=email).id
            pin[iduser] = pinuser
            subject, from_email, to = 'recuperar contraseña', 'monitoreo@solucionesracionales.com', email
            text_content = ''
            html_content = '<p>Para recuperar contraseña dirigase a:<br><a href="http://146.255.98.30/sigestar/recuperar/?pin={}">Link para recuperar contraseña</a><br>Si Ud no pidio una recuperacion de contraseña ignore este mensaje.</p>'.format(
                pinuser)
            msg = EmailMultiAlternatives(subject, text_content, from_email, [to])
            msg.attach_alternative(html_content, "text/html")
            msg.send()
            msj = "Se ha enviado un link a su correo desde el cual podrá obtener su usuario y una nuvea contraseña"
        else:
            msj = "El correo ingresado no pertenece a ningún usuario del sistema. Si eres usuario ponte en contacto con el administrador"
        return render_to_response("respuesta.html", {'respuesta': msj})
    raise Http404


def recuperar(request):
    if 'pin' in request.GET:
        a = None
        for iduser, p in pin.items():
            if p == request.GET.get('pin'):
                a = iduser
        if a:
            u = User.objects.get(id=a)
            return render_to_response("recuperar.html", {'u': u}, context_instance=RequestContext(request))
    raise Http404


def enviar_con(request):
    if request.method == "POST" and 'id' in request.POST and request.POST.get('id').isdigit():
        del pin[int(request.POST.get('id'))]
        if 'enviar' in request.POST:
            u = User.objects.get(id=request.POST.get('id'))
            password = User.objects.make_random_password()
            u.set_password(password)
            u.save()
            message = "Su usuario es: {} y su nueva contraseña es: {}".format(u.username, password)
            send_mail('Generacion de nueva contraseña', message, 'monitoreo@solucionesracionales.com', [u.email])
            return redirect(reverse('acccion_correcta', kwargs={'accion': 'enviar'}))
        elif 'cancelar' in request.POST:
            redirect(reverse('user_login'))
    raise Http404


@login_required(login_url=reverse_lazy('user_login'))
def registrar_personal(request):
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    if request.method == 'POST':
        regform = RegistrarPersonal(request.POST)
        if regform.is_valid():
            usuario = User.objects.make_random_password(allowed_chars='0123456789')
            while User.objects.filter(username=usuario):
                usuario = User.objects.make_random_password(allowed_chars='0123456789')
            password = User.objects.make_random_password()
            u = User.objects.create_user(username=usuario,
                                         password=password,
                                         email=regform.cleaned_data['email'])
            u.first_name = regform.cleaned_data['nombre']
            u.last_name = regform.cleaned_data['apellido']
            u.save()
            if regform.cleaned_data['admin']:
                Group.objects.get(name='administradores').user_set.add(u)
            else:
                Group.objects.get(name='empleados').user_set.add(u)
            p = Perfil.objects.create(user=u,
                                      dni=regform.cleaned_data['dni'],
                                      direccion=regform.cleaned_data['direccion'],
                                      telefono=regform.cleaned_data['telefono'],
                                      empresa="solrac" if not regform.cleaned_data['admin'] else regform.cleaned_data[
                                          'empresa'],
                                      dba=regform.cleaned_data['dba']
            )
            p.especialidad = regform.cleaned_data['especialidad']
            p.save()
            message = 'Su usuario es {} y su contraseña es {}'.format(usuario, password)
            if regform.cleaned_data['email']:
                send_mail('creacion de cuenta sigestar', message, 'monitoreo@solucionesracionales.com', [u.email])
            return redirect(reverse('accion_correcta', kwargs={'accion': 'agregar'}))
    else:
        regform = RegistrarPersonal()
    return render_to_response("registrar_usuario.html", {'rf': regform}, context_instance=RequestContext(request))


@login_required(login_url=reverse_lazy('user_login'))
def editar_personal(request):
    hidden = "hidden"
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    emps = User.objects.exclude(groups__name='super')
    if request.method == 'POST':
        if 'guardar' in request.POST:
            formdata = request.POST.copy()
            formdata['dni'] = 'xxxxxxxx'
            formdata['dni2'] = request.POST.get('dni')
            regform = RegistrarPersonal(formdata)
            if regform.is_valid():
                u = User.objects.get(perfil__dni=request.POST.get('dni'))
                u.first_name = regform.cleaned_data['nombre']
                u.last_name = regform.cleaned_data['apellido']
                u.email = regform.cleaned_data['email']
                u.save()
                if regform.cleaned_data['admin']:
                    Group.objects.get(name='administradores').user_set.add(u)
                    if u.get_profile().is_empleado():
                        Group.objects.get(name='empleados').user_set.remove(u)
                else:
                    Group.objects.get(name='empleados').user_set.add(u)
                    if u.get_profile().is_admin():
                        Group.objects.get(name='administradores').user_set.remove(u)
                p = Perfil.objects.get(user=u)
                p.telefono = regform.cleaned_data['telefono']
                p.direccion = regform.cleaned_data['direccion']
                p.especialidad = regform.cleaned_data['especialidad']
                p.dba = regform.cleaned_data['dba']
                p.empresa = regform.cleaned_data['empresa']
                p.save()
                return redirect(reverse('accion_correcta', kwargs={'accion': 'editar'}))
            hidden = ""
        elif 'eliminar' in request.POST and 'dni' in request.POST:
            u = User.objects.get(perfil__dni=request.POST.get('dni'))
            p = Perfil.objects.get(user=u)
            p.delete()
            u.delete()
            return redirect(reverse('accion_correcta', kwargs={'accion': 'eliminar'}))
    else:
        regform = RegistrarPersonal()
        if 'per' in request.GET and request.GET.get('per').isdigit():
            e = get_object_or_404(User, id=request.GET.get('per'))
            regform = RegistrarPersonal(initial={'nombre': e.first_name,
                                                 'apellido': e.last_name,
                                                 'dni': e.get_profile().dni,
                                                 'email': e.email,
                                                 'telefono': e.get_profile().telefono,
                                                 'direccion': e.get_profile().direccion,
                                                 'especialidad': e.get_profile().especialidad.all(),
                                                 'empresa': e.get_profile().empresa,
                                                 'dba': e.get_profile().dba,
                                                 'admin': e.get_profile().is_admin(),
            })
            regform.fields['dni'].widget.attrs['readonly'] = True
            hidden = ""
    return render_to_response("editar_usuario.html", {'emps': emps, 'rf': regform, 'hidden': hidden},
                              context_instance=RequestContext(request))


@login_required(login_url=reverse_lazy('user_login'))
def marcar_asistencia(request):
    if request.is_ajax():
        if request.user.get_profile().is_empleado() and not Asistencia.objects.filter(
                user=request.user, fecha__day=now().day, fecha__month=now().month, fecha__year=now().year):
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
                try:
                    registrar_inasistencias(now() - timedelta(hours=5), request.user)
                except Exception:
                    print Exception
                Asistencia.objects.create(user=request.user, fecha=now(), valor=True,
                                          turno_ini=datetime.combine(now().date(), time(0, 0, 1)))
                return HttpResponse("Ud ya marco asistencia")
    return Http404


@login_required(login_url=reverse_lazy('user_login'))
def cambiar_horario(request):
    select = None
    hidden = "hidden"
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    form = RegistrarHorario()
    emps = User.objects.filter(groups__name='empleados')
    if request.method == 'POST':
        if 'guardar' in request.POST:
            form = RegistrarHorario(request.POST)
            u = User.objects.get(id=request.POST.get('id'))
            if u.get_profile().horario:
                registrar_inasistencias(now() - timedelta(hours=5), u)
                p = u.get_profile()
                p.horario.delete()
                p.horario = None
                p.save()
            if not u.get_profile().horario and form.is_valid():
                for turno in form.cleaned_data.values():
                    if turno:
                        h = Horario.objects.create()
                        for key, value in form.cleaned_data.items():
                            if value:
                                h.dias.add(Campo(dia=Dia.objects.get(nombre=key), turno=value, horario=h))
                        p = u.get_profile()
                        p.horario = h
                        p.save()

                        break
            return redirect(reverse('accion_correcta', kwargs={'accion': 'horario'}))
    else:
        if 'per' in request.GET and request.GET.get('per').isdigit():
            u = get_object_or_404(User, id=request.GET.get('per'))
            select = u.id
            if u.get_profile().horario:
                initial = {}
                for dia in u.get_profile().horario.dias.all():
                    initial[dia.dia.nombre] = dia.turno
                form = RegistrarHorario(initial=initial)
            hidden = ""
    return render_to_response("cambiar_horario.html", {'form': form, 'emps': emps, 'select': select, 'hidden': hidden},
                              context_instance=RequestContext(request))


@login_required(login_url=reverse_lazy('user_login'))
def ver_asistencia(request):
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    select = None
    asis = None
    emps = User.objects.filter(groups__name='empleados').exclude(perfil__horario=None)
    if 'per' in request.GET and request.GET.get('per').isdigit():
        u = get_object_or_404(User, id=request.GET.get('per'))
        select = u.id
        registrar_inasistencias(now() - timedelta(hours=5), u)
        asis = Asistencia.objects.filter(user=u)
    return render_to_response("asistencia.html", {'emps': emps, 'asis': asis, 'select': select},
                              context_instance=RequestContext(request))


@login_required(login_url=reverse_lazy('user_login'))
def rotar_horario(request):
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    emps = User.objects.filter(groups__name='empleados').exclude(perfil__horario=None)
    if request.method == 'POST':
        arotar = User.objects.get(id=request.POST.get('arotar')).get_profile()
        rotarpor = User.objects.get(id=request.POST.get('rotarpor')).get_profile()
        registrar_inasistencias(now() - timedelta(hours=5), arotar.user)
        registrar_inasistencias(now() - timedelta(hours=5), rotarpor.user)
        arotar.horario, rotarpor.horario = rotarpor.horario, arotar.horario
        rotarpor.save()
        arotar.save()
        return redirect(reverse('accion_correcta', kwargs={'accion': 'rotar'}))

    return render_to_response("rotar.html", {'emps': emps}, context_instance=RequestContext(request))


@login_required(login_url=reverse_lazy('user_login'))
def ver_turnos(request):
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    turnos = Turno.objects.all()
    return render_to_response("agregar_turno.html", {'turnos': turnos}, context_instance=RequestContext(request))


@login_required(login_url=reverse_lazy('user_login'))
def agregar_turno(request):
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    if request.method == 'POST':
        if 'ini' in request.POST and 'fin' in request.POST:
            Turno.objects.create(hora_ini=request.POST.get('ini'), hora_fin=request.POST.get('fin'))
            return redirect(reverse('ver_turnos'))


@login_required(login_url=reverse_lazy('user_login'))
def eliminar_turno(request):
    if not request.user.get_profile().is_super():
        return redirect(reverse('user_login'))
    if 'id' in request.GET:
        t = Turno.objects.get(id=request.GET.get('id'))
        t.delete()
    return redirect(reverse('ver_turnos'))