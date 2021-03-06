define (require) ->
	GameObject = require 'GameObject'
	{ Unique } = GameObject
	Counter = require './Counter'

	###
	Class: ScoreKeeper
	Tracks the score. Updates the Counters.
	Is Unique.
	###
	class ScoreKeeper extends GameObject
		@does Unique

		###
		Constructor: ScoreKeeper
		###
		constructor: ->
			super()

			@left = @emit new Counter -100, 'wasd'
			@right = @emit new Counter 100, 'arrows'

		###
		Method: ScoreLeft
		One more point for the left player.
		Returns whether they won.
		###
		scoreLeft: ->
			@_score @left

		###
		Method: ScoreRight
		One more point for the right player.
		Returns whether they won.
		###
		scoreRight: ->
			@_score @right

		_score: (counter) ->
			type counter, Counter
			counter.increase()
