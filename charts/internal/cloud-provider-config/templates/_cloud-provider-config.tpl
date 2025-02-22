{{- define "cloud-provider-config" -}}
global:
  soapRoundtripCount: {{ .Values.soapRoundtripCount }}
  ipFamily:
  - ipv4
  {{- if .Values.caFile }}
  caFile: "{{ .Values.caFile }}"
  {{- end }}
  {{- if .Values.thumbprint }}
  thumbprint: "{{ .Values.thumbprint }}"
  {{- end }}

vcenter:
  {{ .Values.serverName }}:
    server: {{ .Values.serverName }}
    port: {{ .Values.serverPort }}
    datacenters:
    {{- range .Values.datacenters }}
    - {{ . | quote }}
    {{- end }}
    user: "{{ .Values.username }}"
    password: "{{ .Values.password }}"
    insecureFlag: {{ .Values.insecureFlag }}

{{- if (or .Values.labelRegion .Values.labelZone) }}
labels:
{{- if .Values.labelRegion }}
  region: "{{ .Values.labelRegion }}"
{{- end }}
{{- if .Values.labelZone }}
  zone: "{{ .Values.labelZone }}"
{{- end }}
{{- end }}

loadBalancer:
  {{- if .Values.loadbalancer.lbServiceId }}
  lbServiceId: "{{ .Values.loadbalancer.lbServiceId }}"
  {{- end }}
  ipPoolName: "{{ .Values.loadbalancer.ipPoolName }}"
  size: {{ .Values.loadbalancer.size }}
  tier1GatewayPath: "{{ .Values.loadbalancer.tier1GatewayPath }}"
  tcpAppProfileName: "{{ .Values.loadbalancer.tcpAppProfileName }}"
  udpAppProfileName: "{{ .Values.loadbalancer.udpAppProfileName }}"
  tags:
  {{- range $k, $v := .Values.loadbalancer.tags }}
    {{ $k }}: {{ $v | quote }}
  {{- end }}

loadBalancerClass:
{{- range $i, $class := .Values.loadbalancer.classes }}
  {{ $class.name }}:
    name: {{ $class.name }}
    {{- if $class.ipPoolName }}
    ipPoolName: "{{ $class.ipPoolName }}"
    {{- end }}
    {{- if $class.tcpAppProfileName }}
    tcpAppProfileName: "{{ $class.tcpAppProfileName }}"
    {{- end }}
    {{- if $class.udpAppProfileName }}
    udpAppProfileName: "{{ $class.udpAppProfileName }}"
    {{- end }}
{{- end }}

nsxt:
  user: "{{ .Values.nsxt.username }}"
  password: "{{ .Values.nsxt.password }}"
  host: "{{ .Values.nsxt.host }}"
  insecureFlag: {{ .Values.nsxt.insecureFlag }}
  remoteAuth: {{ .Values.nsxt.remoteAuth }}
{{- end -}}