define (require) ->
	GameState = require 'GameState'
	ImageObject = require '../Objects/ImageObject'
	Controller = (require 'GameObject').Controller
	PauseToggle = require '../Objects/PauseToggle'
	Vec2 = require 'Vec2'

	###
	A state that displays the start screen and starts when a button is pressed.
	###
	class Start extends GameState
		constructor: ->
			super 1024, 512
			@addObject new ImageObject 'Start.png', 0, 512, 512
			@addObject new Controller
			@addObject new PauseToggle
			@camera.lookAt Vec2.zero()
			@camera.moveInside @rect()

		changeState: ->
			Pong = require './Pong'
			@game.createState 'pong', new Pong
			@game.changeState 'pong'
