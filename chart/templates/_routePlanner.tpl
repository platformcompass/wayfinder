{{/*
Create resources for each chart in GitOps charts
*/}}
{{- define "wayfinder.routeplanner" -}}
{{- if .Values.GitOps.Flux.enabled -}}
{{- with .Values.GitOps.charts -}}
{{- range $index, $chart := . }}
{{- include "wayfinder.helmrepository" (list $ . ) }}
{{- include "wayfinder.helmrelease" (list $ . ) }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}