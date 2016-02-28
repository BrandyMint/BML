//= require lodash

function enableElement($el) {
  $el.prop('disabled', false);
}

function disableElement($el) {
  $el.prop('disabled', true);
}

$(document).ready(function() {
  var changeListeners = $('[data-enable-when-changed=true]');
  var presendListeners = $('[data-enable-when-presend]');

  _.each(changeListeners, function(listener) {
    var $el = $(listener);
    var $form = $el.closest('form');
    var onChange = function(ev) {
      var target = ev.target;

      if (target.type === 'file' || target.type === 'textarea') {
        $form.data('changed', true);
      }

      $form.data('changed') || $form.data('initialValues') !== $form.serialize()
        ? enableElement($el)
        : disableElement($el);
    };

    disableElement($el);
    $form.data('initialValues', $form.serialize());
    $form.on('change keyup paste', 'textarea, :input', onChange);
  });

  _.each(presendListeners, function(listener) {
    var $el = $(listener);
    var $form = $el.closest('form');
    var onChange = function(ev) {
      var target = ev.target;

      if (target.type === 'file' || target.type === 'textarea') {
        $form.data('changed', true);
      }

      $form.data('changed') ? enableElement($el) : disableElement($el);
    };

    $form.on('change keyup paste', 'textarea, :input', onChange);
  });
});
