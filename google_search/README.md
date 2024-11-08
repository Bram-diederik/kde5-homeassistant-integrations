This Script runs a custom google search https://programmablesearchengine.google.com
and uses the rest interface to add the results in home assistant


script/automation yaml snippet
```
action: shell_command.google_search
data:
  query: |
    {{trigger.slots.query}}
```


dashboard card
```
type: markdown
content: >
  {% for i in range(10) %}

  ## [{{ state_attr("sensor.google_search_" + i|string, "title") }}]({{
  state_attr("sensor.google_search_" + i|string, "link") }})

  {{ state_attr("sensor.google_search_" + i|string, "snippet") }}

  {% endfor %}
```


authorized_keys
```
command="/home/daft/bin/google_search.sh -q \"$(cat)\"",restrict <the ssh key>
```





