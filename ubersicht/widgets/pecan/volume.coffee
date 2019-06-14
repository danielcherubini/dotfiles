command: "bash pecan/scripts/volume"

refreshFrequency: 5000 # ms

render: (output) ->
  "<div class='screen'><div class='pecanvolume'>#{output}</div></div>"
