# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready (e) ->

  $('.typeahead', '#administrators').typeahead
    source: (typeahead, query) ->
      $.ajax
        url: '/admin/administrators/search'
        dataType: 'json'
        data: {q: query}
        success: (data) ->
          typeahead.process(data)
          true
      true
    true
  true
