# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready (e) ->

  # Handlers for requests-list table
  if $('#requests-list').length > 0

    $('.reject-request').click (e) ->
      e.preventDefault()

      reqId = $(this).attr('id').match(/-(\d+)$/)[1]
      requestor = $('#requestor-' + reqId).html()
      $('#reject-form').html($('#reject-form-template').tmpl({requestId: reqId, requestor: requestor}))
      $('#reject-form').modal()

      true
  
  true
