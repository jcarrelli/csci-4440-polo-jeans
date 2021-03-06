define (require) ->
	require 'meta'
	extend = (require 'jquery').extend
	GameObject = require './GameObject'
	CallsBack = require './CallsBack'
	Inits = require './Inits'
	Controller = require './Controller'

	###
	Trait: ListensToControl
	###
	class ListensToControl
		@does CallsBack, Inits

		@onDoes (user) ->
			extend user,
				###
				Class Method: onPress
				Adds a callback for when a button is pressed.
				###
				onPress: (button, func) ->
					@onKey 'press', button, func

				###
				Class Method: onRelease
				Adds a callback for when a button is released.
				###
				onRelease: (state, func) ->
					@onKey 'release', button, func

		###
		Method: init
		Registers me with the Controller.
		###
		@onInit ->
			(@the Controller).registerListener @

		###
		Method: isButtonDown
		Whether the given button is down.
		###
		isButtonDown: (button) ->
			(@the Controller).isButtonDown button

		###
		Method: buttonDown
		Called by Controller when a button is pushed.
		Parameters:
			button - The button that was pushed.
		###
		onButtonDown: (button) ->
			@callBackMap @_on_press, button

		###
		Method: buttonUp
		Called by Controller when a button is lifted.
		Parameters:
			button - The button that was lifted.
		###
		onButtonUp: (button) ->
			@callBackMap @_on_release, button
