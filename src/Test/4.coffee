define (require) ->
	{ PlayState } = require 'GameState'
	{ Controller, ListensToControl, MoveSprite } = require 'GameObject'
	Player = require './Player'
	Vec2 = require 'Vec2'

	class Enemy extends MoveSprite
		constructor: ->
			super()
			@warp new Vec2 200, 0

		animationSize: ->
			[64, 64]

		step: ->
			super()

			@eachColliding Player, =>
				@die()

			#Alternate
			#if @collides @the Player
			#	@die()



	class Test4 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new Controller
			@addObject new Player
			@addObject new Enemy

			@camera.lookAt Vec2.zero()
