define (require) ->
	PlayState = (require 'GameState').PlayState
	GameState = require 'GameState'
	Ball = require '../Objects/Ball'
	Paddle = require '../Objects/Paddle'
	WinWASD = require './WinWASD'
	WinArrows = require './WinArrows'
	ImageObject = require '../Objects/ImageObject'
	PauseToggle = require '../Objects/PauseToggle'
	ScoreKeeper = require '../Objects/ScoreKeeper'
	Controller = (require 'GameObject').Controller

	###
	A state that plays the Pong game.
	It has a ball, 2 paddles, and a score keeper.
	###
	class Pong extends PlayState
		constructor:  (state) ->
			@_width = 1024
			@_height = 512
			super(state)
			unless state instanceof GameState
				paddleMargin = 64
				@addObject new ImageObject 'Arena.png', 1024, 1024
				@addObject new Controller
				@addObject ball = new Ball
				@addObject new Paddle (-@width()/2 + paddleMargin), 'wasd'
				@addObject new Paddle (@width()/2 - paddleMargin), 'arrows'
				#bug - changeState called twice on enter if re-added here.
				#@addObject new PauseToggle
				@addObject new ScoreKeeper
		width: ->
			@_width
		height: ->
			@_height
		
		#go to win state
		win: (whoLost) ->
			if whoLost is 'wasd'
				@game.createState 'win', new WinArrows
				@game.changeState 'win'
			else
				@game.createState 'win', new WinWASD
				@game.changeState 'win'

		#switch between pause and play states
		changeState: ->
			Pause = require './Pause'
			###
			#bug - no way to remove/re-add pauseimage on top without remaking state
			if @game.containsState 'pause'
				@game.changeState 'pause'
			else
			###
			@game.createState 'pause', new Pause @
			@game.changeState 'pause'
