require 'net/http'
require_dependency 'web_viewer_service'



class HtmlEmitter
    REDIRECTION_LIMIT = 9

	def initialize
		@start = 0
		@listeners = Array.new()
	end

	def addListener(listener)
		@listeners << listener
	end

	def parse(str)
        ws = WebviewerService.new
		ar = ws.split_into_lines(str)
		loop do
			el = ws.emit_elements
			if(el)
				case el[:type]
				when 'P' then
					fire(:para, el)
				when 'IMG' then
					fire(:image, el)
				end
			end
			break if !el
		end
	end

	def fire(sym, el)
        mth = "emit_#{sym}"
		@listeners.each do |list|
			if list.respond_to? mth 
				list.send(mth, el)
			end 
		end
	end
end