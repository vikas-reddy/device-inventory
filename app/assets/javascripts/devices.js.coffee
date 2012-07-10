# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready (e) ->

  if($('#device-form'))

    window.tmplIndex = -1

    $('[rel="tooltip"]', '#device-form').tooltip()

    # Add Accessory
    $('#add-accessory', '#device-form').on 'click', (e) ->
      e.preventDefault()

      form = $('#new-accessory-template').tmpl({index: window.tmplIndex--})
      $('#add-accessory-container').before(form)
      return false

    # Remove Accessory
    $('#device-form').on 'click', '.remove-accessory', (e) ->
      e.preventDefault()

      $(this).closest('.accessory-form-inline').remove()
      return false
