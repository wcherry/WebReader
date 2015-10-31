# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  window.line_index = 0
  console.log("DOM is ready")
  $(".image_view").click ->
  	console.log("button clicked!")


  $(window).scroll ->
  	console.log("Scrolling")

  	max_line = 0
  	$('.marker').each( (id,x) =>
  		if isScrolledIntoView(x)
  			line = parseInt($(x).attr('data-line'))
  			if line > max_line 
  				max_line = line
  	)
  	
  	if max_line > window.line_index
  		window.line_index = max_line
  		console.log("New index #{max_line}")
  		update_page_position(max_line, page_url)

isScrolledIntoView = (elem) ->
    docViewTop = $(window).scrollTop()
    docViewBottom = docViewTop + $(window).height()
    elemTop = $(elem).offset().top
    return ((elemTop <= docViewBottom) && (elemTop >= docViewTop))


update_page_position = (line, url) ->
	$.ajax
	   url: "/webview/update_page_position"
	   data: {"line_number": line, "url": url} 
	   dataType: "json"
	   error: (jqXHR, textStatus, errorThrown) ->
	     console.log("AJAX Error: #{textStatus}")
	   success: (data, textStatus, jqXHR) ->
	     console.log("Successful AJAX call: #{data}")
