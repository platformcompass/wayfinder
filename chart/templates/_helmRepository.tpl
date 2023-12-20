{{- define "wayfinder.helmrepository" }}
{{- $ := index . 0 }}
{{- $arg := index . 1 }}
{{ with $arg }}
---
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: {{ .name }}
  namespace: {{ default .namespace .name }}
spec:
  interval: {{ default "10m0s" .interval }}
  provider: generic
  url: {{ .repository }}
{{- end }}
{{- end }}