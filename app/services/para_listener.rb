require_dependency 'para_element'

class ParaListener
	attr_reader :data
	
	def initialize
		@data = []
		@line = 1
	end
	def emit_para(el)
		@data << Para.new(el[:text]).appendAttr("data-line", @line).appendAttr("class", 'marker')
		@line+=1
	end

	def to_s
		@data.join("\n")
	end
end