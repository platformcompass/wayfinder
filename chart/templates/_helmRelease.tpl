{{- define "wayfinder.helmrelease" }}
{{- $ := index . 0 }}
{{- $arg := index . 1 }}
{{ with $arg }}
{{- $valuesPath := printf "{{ $.Values.%s | toYaml }}" .alias -}}
{{- $values := tpl $valuesPath $ -}}
---
apiVersion: helm.toolkit.fluxcd.io/v2beta2
kind: HelmRelease
metadata:
  name: {{ .name }}
  namespace: {{ default .namespace .name }}
spec:
  chart:
    spec:
      chart: {{ .name }}
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: HelmRepository
        name: {{ .name }}
      version: {{ .version }}
      values:
      {{- if $values -}}
      {{ $values | nindent 8 }}
      {{- end }}
  {{- if  .dependsOn }}
  dependsOn:
  {{- toYaml .dependsOn | nindent 2 }}
  {{- end }}
  interval: 10m0s
  {{- end }}
{{- end }}