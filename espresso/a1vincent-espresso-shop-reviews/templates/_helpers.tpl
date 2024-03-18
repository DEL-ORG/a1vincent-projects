{{/*
Expand the name of the chart.
*/}}
{{- define "a1vincent-espresso-shop-reviews.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "a1vincent-espresso-shop-reviews.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "a1vincent-espresso-shop-reviews.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "a1vincent-espresso-shop-reviews.labels" -}}
helm.sh/chart: {{ include "a1vincent-espresso-shop-reviews.chart" . }}
{{ include "a1vincent-espresso-shop-reviews.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "a1vincent-espresso-shop-reviews.labels-2" -}}
helm.sh/chart: {{ include "a1vincent-espresso-shop-reviews.chart" . }}
{{ include "a1vincent-espresso-shop-reviews.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "a1vincent-espresso-shop-reviews.selectorLabels" -}}
app.kubernetes.io/name: {{ include "a1vincent-espresso-shop-reviews.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "a1vincent-espresso-shop-reviews.selectorLabels-2" -}}
app.kubernetes.io/name: {{ include "a1vincent-espresso-shop-reviews.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "a1vincent-espresso-shop-reviews.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "a1vincent-espresso-shop-reviews.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
