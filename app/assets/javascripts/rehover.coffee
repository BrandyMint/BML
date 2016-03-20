$(document).on 'ready page:load', ->
  onHover = (event) ->
    $el = $ event.target

    unless $el.data 'saved'
      $el.data 'saved', class: $el.attr('class'), content: $el.html()

    data = $el.data('rehover').hover

    $el.attr 'class', data.class
    $el.html "<i class=\"fa fa-#{data.icon}\"/> #{data.title}"

  onLeave = (button) ->
    $el = $ event.target

    saved = $el.data 'saved'

    if saved
      $el.attr 'class', saved.class
      $el.html saved.content
    else
      console.error? "Cтранное дело, нет сохраненых данных у rehover-элемента", $el

  $('[data-rehover]').hover onHover, onLeave
