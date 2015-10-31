class ImageListener
	def initialize
		@images = Array.new
	end
	def image(el)
		@images << el[:image]
	end

	def images
		@images
	end
end