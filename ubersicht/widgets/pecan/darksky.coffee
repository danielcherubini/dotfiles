
command: "bash pecan/scripts/darksky"

refreshFrequency: '15m' # every 15 minutes

render: (output) ->
	if (output)
		weather = JSON.parse(output)
		icon = '<img style="width:8px;height:8px;margin-right:4px;" src="pecan/images/mono/'
		icon += weather.currently.icon
		icon += '.png">'
		"<div class=\"screen\"><div class=\"weather\">#{icon}#{weather.currently.temperature.toFixed(1)}'c</div></div>"
