$(document).on 'ready page:load', ->
  $('.handle').closest('tbody').accountTableSortable
    forceFallback: true,
    ghostClass: 'row--highlight',
