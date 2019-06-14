command: "bash pecan/scripts/volume"

refreshFrequency: 50 # ms

render: (output) ->
  "<div class='screen'><div class='pecanvolume'>#{output}</div></div>"
