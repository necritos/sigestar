from django import forms
from appsistema.models import Tipo, Categoria, Rubro

class SolicitudForm(forms.Form):
    emisor = forms.CharField(max_length=100)
    tipo = forms.ModelChoiceField(queryset=Tipo.objects.all(), empty_label=None)
    categoria = forms.ModelChoiceField(queryset=Categoria.objects.all(), empty_label=None)
    rubro = forms.ModelChoiceField(queryset=Rubro.objects.all(), required=False)
    descripcion = forms.CharField(widget=forms.Textarea, required=False)

    def clean_descripcion(self):
        descripcion = self.cleaned_data['descripcion']
        if descripcion == '': raise  forms.ValidationError("Debe ingresar una descripcion")
        return descripcion

    def __init__(self, user, *args, **kwargs):
        super(SolicitudForm, self).__init__(*args, **kwargs)
        if user.get_profile().empresa == 'telefonica':
            self.fields['categoria'].queryset = Categoria.objects.exclude(nombre="trabajo asignado").exclude(
                nombre="trabajo programado")