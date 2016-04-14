'use strict';

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

function onStart(_ref) {
  var item = _ref.item;

  $(item).children().each(function (index) {
    $(this).width($(this).width());
  });
}

function onUpdate(_ref2) {
  var item = _ref2.item;
  var newIndex = _ref2.newIndex;
  var oldIndex = _ref2.oldIndex;

  var $item = $(item).find('[data-sort-url]');
  var url = $item.data('sort-url');

  if (oldIndex !== newIndex && url) {
    (function () {
      var start = $item.data('sort-start') || 0;
      var method = $item.data('sort-post') || 'POST';
      var position = $item.data('sort-position') || newIndex + 1;
      var onSuccess = $item.data('sort-success-action');
      var customParams = $item.data('sort-custom-params') || {};

      if (typeof customParams === 'string') {
        customParams = JSON.parse(customParams);
      }

      $.ajax({
        url: url,
        method: method,
        data: _extends({}, customParams, { position: position, start: start })
      }).then(function () {
        if (onSuccess !== 'nothing') {
          window.location.reload();
        }
      }).fail(function () {
        alert('Error when saving sorting');
      });
    })();
  }
}

$.fn.sortableJS = function (options) {
  var retVal;
  var args = arguments;

  this.each(function () {
    var $el = $(this);
    var sortable = $el.data('sortable');

    if (!sortable && (options instanceof Object || !options)) {
      sortable = new Sortable(this, options);
      $el.data('sortable', sortable);
    }

    if (sortable) {
      if (options === 'widget') {
        return sortable;
      } else if (options === 'destroy') {
        sortable.destroy();
        $el.removeData('sortable');
      } else if (typeof sortable[options] === 'function') {
        retVal = sortable[options].apply(sortable, [].slice.call(args, 1));
      } else if (options in sortable.options) {
        retVal = sortable.option.apply(sortable, args);
      }
    }
  });

  return retVal === void 0 ? this : retVal;
};

$.fn.accountSortable = function (options) {
  this.sortableJS(_extends({
    onStart: onStart,
    onUpdate: onUpdate,
    ghostClass: 'sortable-ghost',
    animation: 150,
    forceFallback: true
  }, options));
};

$.fn.accountTableSortable = function (options) {
  this.sortableJS(_extends({
    onStart: onStart,
    onUpdate: onUpdate,
    handle: '.handle',
    ghostClass: 'sortable-ghost',
    animation: 150,
    forceFallback: true
  }, options));
};
