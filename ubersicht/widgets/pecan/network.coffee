command: "bash pecan/scripts/network"

refreshFrequency: 5000 # ms

render: (output) ->
  "<div class='screen'><div class='pecannetwork'><i class='fas fa-wifi'></i> -#{output}</div></div>"
