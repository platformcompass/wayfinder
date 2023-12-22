---
{{- with (datasource "values") }}
{{ .version }}
{{- end }}
