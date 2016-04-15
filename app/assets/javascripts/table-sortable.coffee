$(document).on 'ready page:load', ->
  $('.handle').closest('tbody')..sortableJS
    forceFallback: true,
    ghostClass: 'row--highlight',
    onStart: onStart,
    onUpdate: onUpdate,
    handle: '.handle',
    ghostClass: 'sortable-ghost',
    animation: 150,
    forceFallback: true
