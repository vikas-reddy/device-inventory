# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready (e) ->

  # Add Accessory
  $('#add-accessory').on 'click', (e) ->
    e.preventDefault()
    $('#add-accessory').hide()
    $('#new-accessory').show()

  $('#new-accessory .cancel').on 'click', (e) ->
    e.preventDefault()
    $('#add-accessory').show()
    $('#new-accessory').hide()

  $('.remove-accessory').on 'click', (e) ->
    e.preventDefault()
    accId = $(this).attr('id').match(/-(\d+)$/)[1]

    $.ajax
      method: 'delete'
      url: $(this).attr('href')
      complete: ->
        $('accessory-row-' + accId).remove()
        false

