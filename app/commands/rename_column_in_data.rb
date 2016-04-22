# Перименовывает ключ в поле `data` у lead-ов
class RenameColumnInData
  include Virtus.model strict: true
  include PlainSQLQuery

  attribute :collection_id, Integer
  attribute :column_was, String
  attribute :column_new, String

  def perform
    execute_query "update collection_items set data = change_hstore_key(data, '#{column_was}', '#{column_new}') where collection_id=#{collection_id}"
  end
end
