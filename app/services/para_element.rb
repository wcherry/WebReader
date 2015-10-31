class Para
	attr_reader :attributes, :text

	def initialize(text)
		@attributes = {}
		@text = text
	end

	def appendAttr(k,v)
		@attributes[k] = v
		self
	end


	def to_s
		"<p #{@attributes.map{|k,v| "#{k}='#{v}'"}.join(' ')}>#{@text}</p>"
	end
end