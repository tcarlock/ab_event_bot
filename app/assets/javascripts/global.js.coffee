$(document).ready ->
  $('.preview-event').click (evt) ->
    window.open $(evt.target).attr('href')
    # $('#page_preview_modal').on('show', ->
    #   $('#page_preview_frame').attr 'src', $(evt.target).attr('href')
    # ).modal('show')
    evt.preventDefault()

  $('#source').change ->
    location.href = "/event_sources/#{$(this).val()}"

  $('#post_event').click ->
    alert 'test'
    $('#post_event').val('true')
    console.log $('#post_event').val()