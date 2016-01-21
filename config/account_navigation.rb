# -*- coding: utf-8 -*-
# configures your navigation

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'nav'

    primary.item :home, 'ДОМ', account_root_path, icon_class: 'fa fa-database'
    primary.item :editor, 'Редактор', account_editor_path, icon_class: 'fa fa-briefcase'
    primary.item :data, 'Данные', account_data_path, icon_class: 'fa fa-user'
    primary.item :analytics, 'Аналитики', account_data_path, icon_class: 'fa fa-user'

    # primary.item :landings, 'Версии', '#' do |landings|
    # landings.item :version1, 'Версия 1', '#'
    # end

    primary.auto_highlight = true
  end
end
