$(function(){
  $('[filter-variant]').on('click', function (e) {
    $(this).parents('.dropdown').find('[name=variant_id]').val($(this).attr('value'));
    $(this).closest('form').submit();
  });

  $('[filter-term]').select2({
    minimumInputLength: 1,
    tags: "true",
    ajax: {
      url: gon.api_url + "v1/utm_values/autocomplete.json",
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return {
          query: params.term,
          key_type: $(this).attr('name'),
          landing_id: gon.current_landing_id
        }
      },
      processResults: function(data, params){
        return {
          results: data.items
        }
      },
      cache: true
    }
  })
  .on('change', function(e){
    var option = $(this).find(':selected');
    option.attr('value', option.text());
    $(this).closest('form').submit();
  });
});
