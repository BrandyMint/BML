module ColumnsHelper
  def column_visibility_button(column)
    if column.is_hidden
      hoverable_off_button(
        unhide_landing_collection_column_path(current_landing, column.collection, column),
        title: 'Скрыта',
        hover_title: 'Показать',
        disable_with: 'Включаю'
      )
    else
      hoverable_on_button(
        hide_landing_collection_column_path(current_landing, column.collection, column),
        title: 'Отображается',
        hover_title: 'Скрыть',
        disable_with: 'Скрываю'
      )
    end
  end

  def column_field_hint(column)
    return if column.key == column.title
    column.key
  end
end
