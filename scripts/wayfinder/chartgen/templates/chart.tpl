---
apiVersion: v2
name: wayfinder
description: >
  A Helm chart for installing Voyages (a collection of Helm Charts
  and pre-tested configs to yer cluster).
type: application
{{- with (datasource "values") }}
version: {{ .version }}
appVersion: {{ .appVersion }}

dependencies:
{{- range $index, $chart := .GitOps.charts }}
  - name: {{ .name }}
    alias: {{ .alias }}
    version: {{ .version }}
    repository: {{ .repository }}
    condition: render-subcharts
{{- end }}
{{- end }}
