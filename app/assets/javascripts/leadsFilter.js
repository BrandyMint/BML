var initFilter = function(){
  $('[filter-dropdown]').on('click', function (e) {
    $(this).parents('.dropdown').find('[name=' + $(this).data('target') + ']').val($(this).attr('value'));
    $(this).closest('form').submit();
  });

  $('[filter-term]').selectize({
    valueField: 'value',
    labelField: 'value',
    searchField: 'value',
    create: false,
    onChange: function(value) {
      this.$input.closest('form').submit();
    },
    render: {
      option: function(item, escape) {
        var useCount = item.use_count ? ' (' + item.use_count + ')' : ''
        return '<div><span>' + item.value + useCount + '</span></div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      path = this.$input.data('api-path');
      console.log("query path", path);
      $.ajax({
        url: gon.api_url + path,
        type: 'GET',
        dataType: 'json',
        data: {
          query: query,
          key_type: this.$input.attr('name'),
          landing_id: gon.current_landing_id
        },
        error: function() {
          callback();
        },
        success: function(res) {
          callback(res.items);
        }
      });
    }
  });
};

$(document).on('ready page:load', initFilter);
