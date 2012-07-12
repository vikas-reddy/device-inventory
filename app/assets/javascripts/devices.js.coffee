# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

asInitVals = new Array()
$(document).ready (e) ->
  
  # Device index and search results pages
  if($('#device-list').length > 0)

    oTable = $("#device-list").dataTable(oLanguage:
      sSearch: "Search all columns:"
    )
    $("tfoot input").keyup ->
      oTable.fnFilter @value, $("tfoot input").index(this)

    $("tfoot input").each (i) ->
      asInitVals[i] = @value

    $("tfoot input").focus ->
      if @className is "search_init"
        @className = ""
        @value = ""

    $("tfoot input").blur (i) ->
      if @value is ""
        @className = "search_init"
        @value = asInitVals[$("tfoot input").index(this)]

    # Click a row to go to its show page
    $('#device-list').on 'click', '.clickable', (e) ->
      e.preventDefault
      window.location = $(this).attr('data-url')
      true

    # Tooltips
    $('[rel="tooltip"]', '#device-list').tooltip()
    
    true

  # Device forms in edit and new pages
  if($('#device-form').length > 0)

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

    # Owner and Possesser typeahead
    $('.typeahead', '#device-form').typeahead
      source: (typeahead, query) ->
        $.ajax
          url: '/users/search'
          dataType: 'json'
          data: {q: query}
          success: (data) ->
            typeahead.process(data)

  return true
