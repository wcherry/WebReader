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
      line = view.line_number
    end



    @page_url = page_url
    @text = pl.data.html_safe
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
