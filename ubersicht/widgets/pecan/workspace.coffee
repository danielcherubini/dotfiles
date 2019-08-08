command: "bash pecan/scripts/yab-ws"

refreshFrequency: 500 # ms

render: (output) ->
  "<div class='screen'><div class='pecanworkspace'>#{output}</div></div>"
