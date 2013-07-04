from django import forms
from django.contrib.auth.models import User
from appsistema.models import Rubro
from appcuentas.models import Turno, Perfil

class RegistrarPersonal(forms.Form):
    nombre = forms.CharField(max_length=30, error_messages={'required': 'Este campo es requerido'})
    apellido = forms.CharField(max_length=30, error_messages={'required': 'Este campo es requerido'})
    dni = forms.CharField(min_length=8, max_length=8, error_messages={'required': 'Este campo es requerido'})
    dni2 = forms.CharField(min_length=8, max_length=8, required=False)
    email = forms.EmailField(required=False)
    telefono = forms.CharField(max_length=9, required=False)
    direccion = forms.CharField(max_length=100, required=False)
    especialidad = forms.ModelMultipleChoiceField(queryset=Rubro.objects.all(), required=False,
        widget=forms.SelectMultiple)
    empresa = forms.ChoiceField(choices=(('solrac', 'solrac'), ('telefonica', 'telefonica')))
    dba = forms.BooleanField(required=False)
    admin = forms.BooleanField(required=False)

    def clean_dni(self):
        if Perfil.objects.filter(dni=self.cleaned_data['dni']):
            raise forms.ValidationError('Ya existe otro usuario con este dni.')
        return self.cleaned_data['dni']

    def clean_email(self):
        if User.objects.filter(email=self.cleaned_data['email']):
            if User.objects.get(email=self.cleaned_data['email']).get_profile().dni != self.cleaned_data['dni2']:
                print User.objects.get(email=self.cleaned_data['email']).get_profile().dni
                print self.cleaned_data['dni']
                raise forms.ValidationError('Ya existe otro usuario con este email.')
        return self.cleaned_data['email']


class RegistrarHorario(forms.Form):
    lunes = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)
    martes = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)
    miercoles = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)
    jueves = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)
    viernes = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)
    sabado = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)
    domingo = forms.ModelChoiceField(queryset=Turno.objects.all(), required=False)