module LinksHelper
  def column_hide_button(column)
    return unless column.persisted?
    link_to hide_landing_collection_column_path(current_landing, current_collection, column),
      method: :patch,
      title: 'Скрыть колонку',
      tooltip: true do
      fa_icon 'eye-slash'
    end
  end

  def delete_site_button(landing)
    link_to 'Удалить сайт', landing_url(landing), class: 'btn btn-danger', method: :delete, data: { confirm: 'Удалить сайт на всегда?' }
  end
  def columns_icon(collection)
    link_to landing_collection_columns_path(current_landing, collection), title: 'Колонки', tooltip: true do
      fa_icon :columns
    end
  end

  def columns_button(collection)
    link_to landing_collection_columns_path(current_landing, collection), class: 'btn btn-secondary btn-sm' do
      fa_icon :columns, text: 'Колонки', class: 'm-r-sm'
    end
  end

  def collection_link(collection)
    link_to landing_leads_path(collection_id: collection), class: 'btn btn-secondary btn-sm' do
      fa_icon :table, text: "Таблица: #{collection}", class: 'm-r-sm'
    end
  end

  def settings_collection_button(collection)
    link_to landing_collection_columns_path(current_landing, collection),
            class: 'btn btn-secondary btn-sm',
            data: { placement: :left },
            title: 'Настройка таблицы',
            tooltip: true do
      fa_icon :gear
    end
  end
end
