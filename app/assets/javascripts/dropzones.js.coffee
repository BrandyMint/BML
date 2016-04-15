Dropzone.autoDiscover = false
$(document).on('ready page:load', Dropzone.discover)

$ ->
  Dropzone.options.answerImagesDropzone =
    autoProcessQueue: true
    parallelUploads: 100
    maxFiles: 100
    paramName: 'answer_image'
    dictDefaultMessage: 'Перетащите файлы сюда'
    headers:
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      'X-Api-Key': gon.access_token
    init: ->
      myDropzone = this
      @on 'success', (file) ->
        if file.xhr.response?
          $('[answer-images]').html file.xhr.response
