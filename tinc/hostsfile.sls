include:
  - tinc

{% for netname, network in pillar.get('tinc', {}).items() %}
  {% for hostname, host in network.items() %}

{{ hostname }}-host-entry:
  host.present:
    {%- if host['host_config']['Subnet'] is string %}
    - ip: {{ host['host_config']['Subnet'].split('/') | first }}
    {%- elif host['host_config']['Subnet'] is iterable %}
    - ip: {{ host['host_config']['Subnet'][0].split('/') | first }}
    {%- endif %}
    - names:
      - {{ hostname + "." + netname }}

  {% endfor %}
{% endfor %}
