(function() {
  if ($) {
    var token = $('meta[name="csrf-token"]').attr('content');
    return $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', token);
        if (gon.access_token != null) {
          return xhr.setRequestHeader('X-Api-Key', gon.access_token);
        }
      }
    });
  }
})();
