class ImageListener
	def initialize
		@images = Array.new
	end
	def emit_image(el)
		@images << el[:image]
	end

	def images
		@images
	end
end