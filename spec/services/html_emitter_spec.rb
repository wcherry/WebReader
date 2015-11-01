require 'rails_helper'

RSpec.describe HtmlEmitter, :type => :service do

  before(:each) do
      @emitter = HtmlEmitter.new
      @list = DummyListener.new
      @emitter.addListener(@list)
  end


  context "with a basic html document" do
    it "there should be two para tags and one image tag" do
      @emitter.parse("<p>Line Text</p>\n<img src='image.png'>\n<p>Another line</p>")
      expect(@list.get(:para).length).to eq 2
      expect(@list.get(:image).length).to eq 1
      expect(@list.keys).to contain_exactly(:para, :image)
    end
    it "there should be two para tags and one image tag enclosed in a div tag" do
      @emitter.parse("<div><p>Line Text</p>\n<img src='image.png'>\n<p>Another line</p></div>")
      expect(@list.get(:para).length).to eq 2
      expect(@list.get(:image).length).to eq 1
      expect(@list.keys).to contain_exactly(:para, :image)
    end
    it "there should be two para tags and one image tag with an embedded span tag" do
      @emitter.parse("<p>Line <span> some </span> Text</p>\n<img src='image.png'>\n<p>Another line</p>")
      expect(@list.get(:para).length).to eq 2
      expect(@list.get(:image).length).to eq 1
      expect(@list.keys).to contain_exactly(:para, :image)
    end
    # it "there should be two para tags, one image tag, and one span tag" do
    #   @emitter.parse("<p>Line Text</p>\n<img src='image.png'>\n<p>Another line</p><span> some </span>")
    #   expect(@list.get(:para).length).to eq 2
    #   expect(@list.get(:image).length).to eq 1
    #   expect(@list.keys).to contain_exactly(:para, :image, :span)
    # end
  end


  class DummyListener
  	def initialize
  		@emitters = {}
  	end

  	def emit(mth, args)
      sym = mth.to_s.sub("emit_", "").to_sym
  		ar = @emitters[sym]
  		if !ar
  			ar = []
        @emitters[sym] = ar
  		end
  		ar << args
  	end

  	def get(sym)
  		@emitters[sym]
  	end

    def keys
      @emitters.keys
    end

    def respond_to?(method_sym, include_private = false)
	    if method_sym.to_s =~ /^emit_(.*)$/
	     true
	   else
	     super
	   end
    end

	def method_missing(method_sym, *arguments, &block)
	  # the first argument is a Symbol, so you need to_s it if you want to pattern match
	  if method_sym.to_s =~ /^emit_(.*)$/
	    emit($1.to_sym, arguments)
	  else
	    super
	  end
	end
  end
end