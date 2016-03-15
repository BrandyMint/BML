module PlainSQLQuery
  module_function

  def execute_query(sql)
    ActiveRecord::Base.connection.execute sanitize sql
  end

  def sanitize(sql)
    ActiveRecord::Base.send(:sanitize_sql_array, sql)
  end
end
