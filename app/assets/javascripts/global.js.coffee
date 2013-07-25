$(document).ready ->
  $('.preview-event').click (evt) ->
    $('#page_preview_modal').on('show', ->
      $('#page_preview_frame').attr 'src', $(evt.target).attr('href')
    ).modal('show')
    evt.preventDefault()

  $('#source').change ->
    location.href = "?source=#{$(this).val()}"