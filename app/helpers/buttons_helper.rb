module ButtonsHelper
  def sort_handle(resource)
    sort_url = polymorphic_path resource, action: :sort

    fa_icon_reorder '', 'data-sort-url' => sort_url
  end

  def fa_icon_reorder(buffer = '', opts = {})
    content_tag :i, buffer,
                class: 'handle fa fa-reorder fa-lg',
                data: { placement: :left },
                tooltip_fake: true,
                title: I18n.t('shared.reorder'),
                **opts.symbolize_keys
  end
end
