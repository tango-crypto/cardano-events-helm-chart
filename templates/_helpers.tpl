{{/*
Common labels
*/}}
{{- define "cardano-events-helm-chart.labels" -}}
helm.sh/chart: {{ include "cardano-events-helm-chart.chart" . }}
{{ include "cardano-events-helm-chart.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "cardano-events-helm-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cardano-events-helm-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart name
*/}}
{{- define "cardano-events-helm-chart.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Chart version
*/}}
{{- define "cardano-events-helm-chart.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{/*
Full name
*/}}
{{- define "cardano-events-helm-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}