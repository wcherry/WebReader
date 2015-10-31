require 'para_element'
class ParaListener
	def initialize
		@data = []
		@line = 1
	end
	def para(el)
		@data << Para.new(el[:text]).appendAttr("data-line", @line).appendAttr("class", 'marker')
		@line+=1
	end

	def data
		@data.join("\n")
	end
end