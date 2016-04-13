module LinksHelper
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
