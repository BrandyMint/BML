(function(){
  var FIRST_PREFIX = 'first';
  var LAST_PREFIX = 'last';
  var UTM_FIELDS = [
    'utm_source',
    'utm_campaign',
    'utm_medium',
    'utm_term',
    'utm_content'
  ];

  getQueryParam = function(param) {
    var result =  window.location.search.match(
      new RegExp("(\\?|&)" + param + "(\\[\\])?=([^&]*)")
    );
    return result ? result[3] : false;
  };

  setUtmCookies = function(prefix, condition) {
    for( field of UTM_FIELDS ) {
      if(condition(field, prefix))
        setCookieFromParam(field, prefix);
    };

    if(condition('referer', prefix))
      document.cookie = fieldKey('referer', prefix) + '=' + document.referrer;
  };

  setCookieFromParam = function(field, prefix) {
    var key = fieldKey(field, prefix);
    var value = getQueryParam(field) || '';
    document.cookie = key + '=' + value;
  };

  fieldExists = function(field, prefix) {
    var key = fieldKey(field, prefix);
    return document.cookie.indexOf(key) > -1;
  };

  fieldKey = function(field, prefix) {
    return prefix + '_' + field;
  };

  setUtmCookies(FIRST_PREFIX, function(field, prefix){
    return !fieldExists(field, prefix)
  });

  setUtmCookies(LAST_PREFIX, function(field, prefix){
    return true;
  });
}());
