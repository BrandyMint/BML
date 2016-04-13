module LinksHelper
  def collection_link(collection)
    link_to landing_leads_path(collection_id: collection), class: 'btn btn-secondary btn-sm' do
      fa_icon :table, text: "Таблица: #{collection}", class: 'm-r-sm'
    end
  end
end
