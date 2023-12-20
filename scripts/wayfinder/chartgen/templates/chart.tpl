---
apiVersion: v2
name: wayfinder
description: >
  A Helm chart for installing Voyages (a collection of Helm Charts
  and pre-tested configs to yer cluster).
type: application
version: "{{- (datasource "values").version }}"
appVersion: "{{- (datasource "values").appVersion }}"

dependencies:
{{- with (datasource "values").GitOps.charts -}}
{{- range $index, $chart := . }}
  - name: {{ .name }}
    alias: {{ .alias }}
    version: {{ .version }}
    repository: {{ .repository }}
    condition: render-subcharts
{{- end }}
{{- end }}
