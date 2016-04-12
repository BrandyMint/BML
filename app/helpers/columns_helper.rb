module ColumnsHelper
  def column_field_hint(column)
    return if column.key == column.title
    column.key
  end
end
