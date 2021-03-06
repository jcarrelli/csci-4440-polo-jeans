define (require) ->
	Graphics = require 'Render/Graphics'
	ResourceCache = require 'ResourceCache'

	###
	Class: Animation
	Render a static or animated texture as a sprite. Track and current
	animation and the state of said animation.
	###
	class Animation
		###
		Method: constructor
		Parameters:
		texture - The name of a texture.
		width - The width of the animation in WebGL units.
		height - The height of the animation in WebGL units.
		###
		constructor: (texture, @_width, @_height) ->
			type texture, String
			type @_width, Number
			type @_height, Number

			cache = ResourceCache.instance()
			graphics = Graphics.instance()
			gl = graphics.context

			# Texture
			@_texture = cache.get texture

			# Geometry vertices
			@_sprite = gl.createBuffer()
			gl.bindBuffer gl.ARRAY_BUFFER, @_sprite
			dx = @width() / 2.0
			dy = @height() / 2.0
			gl.bufferData gl.ARRAY_BUFFER, new Float32Array([
				 dx,  dy,
				-dx,  dy,
				 dx, -dy
				-dx, -dy
			]), gl.STATIC_DRAW
			@_layer = 0.0 # Animation layer

			@_frames = @_texture.frames # Animation frames
			@_delay = 0 # Frame delay for current animation
			@_indices = [0] # Frame indices for current animation
			@_timer = 0 # Frame delay timer
			@_index = 0 # Index of current frame index

			# Animation frame vertices
			@_frame = gl.createBuffer()
			gl.bindBuffer gl.ARRAY_BUFFER, @_frame
			gl.bufferData gl.ARRAY_BUFFER, @_frames[0], gl.DYNAMIC_DRAW

		width: ->
			@_width
		height: ->
			@_height

		###
		Method: setLayer
		Set the layer of the animation.
		Parameters:
		layer - The layer of the animation. Must be between -9 and 9
		(inclusive), 0 by default. Higher values are closer to the camera.
		###
		setLayer: (layer) ->
			@_layer = layer / 10.0

		###
		Method: do
		Switch animations within a fixed texture.
		Parameters:
		animation - The name of an animation in the loaded texture.
		###
		do: (animation) ->
			graphics = Graphics.instance()
			gl = graphics.context

			@_delay = @_texture[animation].delay
			@_indices = @_texture[animation].frames
			@_timer = 0
			@_index = 0
			gl.bindBuffer gl.ARRAY_BUFFER, @_frame
			gl.bufferSubData gl.ARRAY_BUFFER, 0, @_frames[@_indices[0]]

		###
		Method: step
		###
		step: ->
			graphics = Graphics.instance()
			gl = graphics.context

			if @_indices.length == 1
				return

			@_timer += 1
			if @_timer >= @_delay
				@_timer = 0
				@_index = (@_index + 1) % @_indices.length
				gl.bindBuffer gl.ARRAY_BUFFER, @_frame
				gl.bufferSubData gl.ARRAY_BUFFER, 0, @_frames[@_indices[@_index]]

		###
		Method: draw
		###
		draw: ->
			cache = ResourceCache.instance()
			shader = cache.get 'default.shad'
			graphics = Graphics.instance()
			gl = graphics.context

			# Refresh transform matrices
			graphics.loadMatrices shader
			gl.uniform1f shader.layer, @_layer
			# Bind geometry to the context
			gl.bindBuffer gl.ARRAY_BUFFER, @_sprite
			gl.vertexAttribPointer shader.vertex, 2, gl.FLOAT, false, 0, 0
			gl.bindBuffer gl.ARRAY_BUFFER, @_frame
			gl.vertexAttribPointer shader.aTexCoord, 2, gl.FLOAT, false, 0, 0
			# Bind texture to the context
			gl.activeTexture gl.TEXTURE0
			gl.bindTexture gl.TEXTURE_2D, @_texture
			gl.uniform1i shader.tex, 0
			# Draw the sprite
			gl.drawArrays gl.TRIANGLE_STRIP, 0, 4
