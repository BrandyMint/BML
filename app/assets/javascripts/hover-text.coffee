$ ->
  onHover = (el) ->
    $el = $ el.target
    $el.data 'hoverSaved', $el.text()
    $el.text $el.data('hoverText')

  onHoverOut = (el) ->
    $el = $ el.target
    $el.text $el.data('hoverSaved')

  $('[data-hover-text]').hover onHover, onHoverOut

