{{/*
Nom complet des objets : <release>-<chart>, sauf si le nom de release contient
déjà le nom du chart. Tronqué à 63 caractères (limite d'un label DNS).
*/}}
{{- define "hello-web.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* Labels de sélection des Pods. Ne doivent JAMAIS changer après la première installation. */}}
{{- define "hello-web.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Labels posés sur tous les objets. */}}
{{- define "hello-web.labels" -}}
{{ include "hello-web.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end -}}
