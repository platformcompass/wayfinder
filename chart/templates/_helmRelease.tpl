{{- define "wayfinder.helmrelease" }}
---
apiVersion: helm.toolkit.fluxcd.io/v2beta2
kind: HelmRelease
metadata:
  name: {{ .name }}
  namespace: {{ .name }}
spec:
  chart:
    spec:
      chart: {{ .name }}
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: HelmRepository
        name: podinfo
      version: {{ .version }}
      dependsOn:
        {{- toYaml .dependsOn | nindent 8 }}
  interval: 10m0s
  {{- end }}