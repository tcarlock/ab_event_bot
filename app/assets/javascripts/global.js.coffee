$(document).ready ->
  $('.preview-event').click (evt) ->
    window.open $(evt.target).attr('href')
    # $('#page_preview_modal').on('show', ->
    #   $('#page_preview_frame').attr 'src', $(evt.target).attr('href')
    # ).modal('show')
    evt.preventDefault()

  $('#source').change ->
    location.href = "/event_sources/#{$(this).val()}"

  $('#category').change ->
    if $(this).val() is ''
      location.href = "/"
    else
      location.href = "?category=#{$(this).val()}"

  $('#region').change ->
    location.href = "?region=#{$(this).val()}"

  $('#post_event').click ->
    $('#post_event').val('true')