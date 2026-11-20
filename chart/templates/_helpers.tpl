{{/*
Name of every object: the release name when it differs from the chart name,
otherwise the chart name. A service is normally installed with its own name
(helm install user-service ...), which keeps object names equal to the
names the platform's NetworkPolicies, Istio policies and Vault roles use.
*/}}
{{- define "svc.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "svc.selectorLabels" -}}
app: {{ include "svc.fullname" . }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "svc.labels" -}}
{{ include "svc.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: spendwise
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Image reference. A digest, which the pipeline writes into the packaged chart,
always wins over the tag: the cluster runs the exact bytes that were scanned
and signed, and a re-pointed tag cannot change what is deployed.
*/}}
{{- define "svc.image" -}}
{{- if .Values.image.digest -}}
{{- printf "%s@%s" .Values.image.repository .Values.image.digest -}}
{{- else -}}
{{- printf "%s:%s" .Values.image.repository (.Values.image.tag | default .Chart.AppVersion) -}}
{{- end -}}
{{- end -}}

{{- define "svc.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- .Values.serviceAccount.name | default (include "svc.fullname" .) -}}
{{- else -}}
{{- .Values.serviceAccount.name | default "default" -}}
{{- end -}}
{{- end -}}

{{- define "svc.volumeName" -}}
{{- printf "writable%s" (. | replace "/" "-" | replace "." "-") | trunc 63 | trimSuffix "-" -}}
{{- end -}}
