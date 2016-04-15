'use strict';

function onStart(ref) {
  var item = ref.item;

  console.log('onStart', ref.oldIndex);
  // TODO Актуально только для таблицы?
  $(item).children().each(function (index) {
    $(this).width($(this).width());
  });
}

function onEnd(ref) {
  var item = ref.item;

  console.log('onEnd', ref.oldIndex, ref.newIndex);
}

function onUpdate(ref) {
  var item = ref.item;
  var newIndex = ref.newIndex;
  var oldIndex = ref.oldIndex;

  console.log('onUpdate', ref.oldIndex, ref.newIndex);
  var $item = $(item).find('[data-sort-url]');
  var url = $item.data('sort-url');

  if (oldIndex !== newIndex && url) {
    (function () {
      var start = $item.data('sort-start') || 0;
      var method = $item.data('sort-method') || 'POST';
      var position = $item.data('sort-position') || newIndex + 1;
      var successAction = $item.data('sort-success-action');
      var data = $item.data('sort-custom-params') || {};

      if (typeof data === 'string') {
        data = JSON.parse(data);
      }

      data['position'] = position;
      data['start'] = start;

      $.ajax({
        url: url,
        method: method,
        data: data,
      }).then(function () {
        if (successAction == 'reload') {
          // TODO Turbolinks?
          window.location.reload();
        }
      }).fail(function () {
        alert('Error when saving sorting');
      });
    })();
  }
}

var OPTIONS = {
  forceFallback: true,
  // draggable: 'div',
  // ghostClass: 'sortable-ghost',
  ghostClass: 'row--highlight',
  onStart: onStart,
  onUpdate: onUpdate,
  onEnd: onEnd,
  handle: '.handle',
  // draggable: '[table-sortable]',
  draggable: 'tr',
  animation: 150,
  forceFallback: false // С форсажем глючит на Safari: в onUpdate newIndex и oldIndex одинаковые
};

var attachSortable = function() {
  var $el = $(this);
  if ($el.data('sortable-inited')) {
    return;
  }
  Sortable.create(this, OPTIONS);
  $el.data('sortable-inited', true);
};

$(document).on('ready page:load', function() {
  $('[table-sortable]').each( attachSortable );
});
