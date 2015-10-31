class Para
	attr_reader :attributes, :text
	attr_accessor :multiple


	def initialize(text)
		@attributes = {}
		@text = text
		@multiple = ["class"]
	end

	# Appends an attribute to the element, if the attribute key is in the multiple
	# list then is can be appended on to the existing attributes (think 'class' attribute)
	def appendAttr(k,v)
		old = @attributes[k]
		if old && @multiple.include?(k)
			v = "#{old} #{v}"
		end
		@attributes[k] = v
		self
	end


	def to_s
		"<p #{@attributes.map{|k,v| "#{k}='#{v}'"}.join(' ')}>#{@text}</p>"
	end
end