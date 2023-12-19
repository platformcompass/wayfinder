{{/*
Create resources for each chart in GitOps charts
*/}}
{{- define "wayfinder.routeplanner" -}}
{{- if .Values.GitOps.Flux.enabled -}}
{{- with .Values.GitOps.charts -}}
{{- range $index, $chart := . }}
{{- include "wayfinder.helmrepository" . }}
{{- include "wayfinder.helmrelease" . }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}