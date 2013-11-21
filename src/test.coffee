###
Tells Jasmine to run the tests.
###

define (require) ->
	require 'jasmine'
	require 'jasmine-html'
	require 'polo-jeans'
	require 'GameObject'

	return ->
		jasmineEnv =
			jasmine.getEnv()
		jasmineEnv.updateInterval =
			1000
		htmlReporter =
			new jasmine.HtmlReporter()
		jasmineEnv.addReporter htmlReporter

		jasmine.specFilter = (spec) ->
			htmlReporter.specFilter spec

		#currentWindowOnLoad = window.onload
		#window.onload = ->
		#	if currentWindowOnLoad?
		#		currentWindowOnLoad()
		jasmineEnv.execute()
