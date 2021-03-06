define (require) ->
	Vec2 = require 'Vec2'
	Inits = require './Inits'
	Rect = require 'Rect'

	###
	Trait: HasPos
	Provides @pos() and related methods.
	###
	class HasPos
		@does Inits

		###
		Event: init
		Sets position to 0.
		###
		@onInit ->
			@_pos = Vec2.zero()

		###
		Method: pos
		My position.
		###
		pos: ->
			@_pos

		###
		Method: warpTo
		Move immediately to the given destination.
		###
		warp: (newPos) ->
			@pos().set newPos

		###
		Method: move
		Move by the given amount.
		Parameters:
			moveBy - Vec of amount to move by.
		###
		move: (moveBy) ->
			@pos().add moveBy

		###
		Method: collides
		Whether I collide with it.
		Parameters:
			other - A HasPos I might collide with.
		###
		collides: (other) ->
			type other, HasPos
			@rect().collides other.rect()

		###
		Method: collideSide
		What side of me other is on. ('left', 'right', 'bottom', 'top')
		###
		collideSide: (other) ->
			type other, HasPos
			@rect().collideSide other.rect()

		###
		Method: rect
		A Rect around pos.
		Requires a method size.
		###
		rect: ->
			Rect.centered @pos(), @size()

		###
		Method: moveInside
		Move me so that I am inside of rect.
		(Must be smaller than it.)
		###
		moveInside: (rect) ->
			type rect, Rect
			@pos().moveInside rect.smallerBy @size()

		###
		Method: eachColliding
		Calls the func on each colliding body in the game.
		###
		eachColliding: (type, fun) ->
			@each type, (obj) =>
				if @collides obj
					fun obj
