define (require) ->
	GO = require 'GameObjects/GameObject'

	GO.CallsBack = require 'GameObjects/CallsBack'
	GO.Inits = require 'GameObjects/Inits'
	GO.HasAnimation = require 'GameObjects/HasAnimation'
	GO.HasFlags = require 'GameObjects/HasFlags'
	GO.Moves = require 'GameObjects/Moves'
	GO.Controller = require 'GameObjects/Controller'
	GO.ListensToControl = require 'GameObjects/ListensToControl'
	GO.Sprite = require 'GameObjects/Sprite'
	GO.MoveSprite = require 'GameObjects/MoveSprite'
	GO.HasSounds = require 'GameObjects/HasSounds'
	GO.HasState = require 'GameObjects/HasState'
	GO.Controller = require 'GameObjects/Controller'
	GO.Camera = require 'GameObjects/Camera'
	GO.Timer = require 'GameObjects/Timer'
	GO.Unique = require 'GameObjects/Unique'
	GO.UsesTimers = require 'GameObjects/UsesTimers'

	GO
