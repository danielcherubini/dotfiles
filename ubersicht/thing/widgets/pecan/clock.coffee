command: "date +\"%H:%M\""

refreshFrequency: 60000 # ms

render: (output) ->
  "<div class='screen'><div class='pecanclock'>→ #{output}</div></div>"
