require 'uri'
class WebviewController < ApplicationController
  def view
    page_url = params[:url]
    puts "Retriving: #{page_url}"
    uri = URI.parse(page_url)

  	he = HtmlEmitter.new()
  	pl = ParaListener.new()
  	il = ImageListener.new()
  	he.addListener(pl)
  	he.addListener(il)
  	he.parse(page_url)

    view = Webview.find_by_url(page_url)
    if view
      line = view.line_number - 1
      for i in 0..line do
        pl.data[i].appendAttr("class", 'read') if pl.data[i]
      end
    end

    @page_url = page_url
    @text = pl.to_s.html_safe
    @images = il.images

  end

  def update_page_position
  	line = params[:line_number]
  	url = params[:url]
  	view = Webview.find_by_url(url)
  	if !view
  		view = Webview.new
  		view.url = url
  	end
  	view.line_number = line
  	if(!view.save!()) 
      puts "ERROR!!!"
    end
    
  	render json: {:view => view}
  end
end
