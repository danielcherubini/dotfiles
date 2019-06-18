#
# Name: DarkSky.Widget
# Destination App: Übersicht
# Created: 09.Jan.2019
# Author: Gert Massheimer
#
# === User Settings ===================================================
#======================================================================
#--- standard iconSet is "color" (options are: color, mono)
iconSet = "color"
#
#--- max 7 days for forecast plus today!
numberOfDays = 8
#
#--- max number of weather alerts
numberOfAlerts = 1
#
#--- show weather alerts (show = true ; don't show = false)
#showAlerts = true
showAlerts = false
#
#--- display as "day" or as "text" or as "icon" or as "iconplus" or as "week"
display = "day"        # Just the banner
#display = "text"       # The banner plus numberOfDays as detailed text
#display = "icon"       # The banner plus 7 days as graph (with small icons)
#display = "iconplus"   # The banner plus "icon" plus 3 days of "text"
#display = "week"       # just 7 days as graph (with small icons)
#
#--- location in degrees
latitude = "59.913868"
longitude = "10.752245"
#
#--- your location (just for display purpose)
myLocation = 'Oslo, Norway'
#
#--- your API-key from DarkSky (https://darksky.net/dev)
apiKey = "2417458ef150eaf10d47462cbddc78b3"
#
#--- select the language (possible "de" for German or "en" for English)
#lang = 'de' # deutsch
lang = 'en' # english
#
#--- select how the units are displayed
units = 'ca' # Celsius and km
#units = 'us' # Fahrenheit and miles
#

#=== DO NOT EDIT AFTER THIS LINE unless you know what you're doing! ===
#======================================================================

command: "curl -s 'https://api.darksky.net/forecast/#{apiKey}/#{latitude},#{longitude}?lang=#{lang}&units=#{units}&exclude=minutely,hourly'"

refreshFrequency: '15m' # every 15 minutes

render: (output) ->
  weather = JSON.parse(output)
  icon = '<img style="width:8px;height:8px;margin-right:4px;" src="pecan/images/mono/'
  icon += weather.currently.icon
  icon += '.png">'
  "<div class=\"screen\"><div class=\"weather\">#{icon}#{weather.currently.temperature.toFixed(1)}'c</div></div>"
