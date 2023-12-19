{{- define "wayfinder.helmrepository" }}
---
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: {{ .name }}
  namespace: {{ .name }}
spec:
  interval: {{ default "10m0s" .interval }}
  provider: generic
  url: {{ .repository }}
{{- end }}