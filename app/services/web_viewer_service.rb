require 'net/http'


class WebviewerService
    REDIRECTION_LIMIT = 9
	def initialize
		@index = 0
        @array = []
	end

    def read_url(url, limit=REDIRECTION_LIMIT)
        raise ArgumentError, 'too many HTTP redirects' if limit == 0
        
        puts "Reading #{url}..."
        uri = URI(url)

        res = Net::HTTP.get_response(uri)

        # Headers
        #res['Set-Cookie']            # => String
        #res.get_fields('set-cookie') # => Array
        #res.to_hash['set-cookie']    # => Array
        #puts "Headers: #{res.to_hash.inspect}"

        # Status
        puts res.code       # => '200'
        puts res.message    # => 'OK'
        puts res.class.name # => 'HTTPOK'

        response = res
        case response
          when Net::HTTPSuccess then
            response
          when Net::HTTPRedirection then
            location = response['location']
            warn "redirected to #{location}"
            read_url(location, limit -1)
          else
            response.value
        end


        # Body
        x = res.body #if res.response_body_permitted?

        puts "Read #{x.length} total bytes"
        x
    end

    def split_into_lines(str)
        @array = str.split(/\r?\n/)
    end

    def emit_elements
        length = @array.length
        el = nil
        loop do
            if (@index > length) 
                return nil
            end
            str = @array[@index]
            @index = @index + 1

            case str 
                when /<p[^>]*>(.*)<\/p>/ then el = {type: 'P', text: $1, line: @index}
                when /<img.+src=\"([^\"]*)\".*>/ then el = {type: 'IMG', image: $1, line: @index}    
                when /<img.+src='([^'']*)'.*>/ then el = {type: 'IMG', image: $1, line: @index}    
            end

            break if el
        end
        el
    end
end
