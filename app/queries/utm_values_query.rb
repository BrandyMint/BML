class UtmValuesQuery
  include Virtus.model

  def search(key, value, landing_id = nil)
    return [] if key.blank? || value.blank? || no_column?(key)

    exec_query(
      [
        %{
          SELECT u.id, u.value, COUNT(l.%s) use_count FROM #{UtmValue.table_name} u
          JOIN #{Lead.table_name} l ON u.value = l.%s
          JOIN #{Variant.table_name} v ON l.variant_id = v.id
          WHERE u.key_type = '%s'
            AND u.value ILIKE '%s'
            %s
          GROUP BY u.id
          ORDER BY use_count DESC
          LIMIT 10
        }, key, key, key, "%#{value}%", landing_query(landing_id)
      ]
    )
  end

  def popular_by_key(key, landing_id = nil)
    return [] if key.blank? || no_column?(key)

    exec_query(
      [
        %{
          SELECT u.id, u.value, COUNT(l.%s) use_count FROM #{UtmValue.table_name} u
          JOIN #{Lead.table_name} l ON u.value = l.%s
          JOIN #{Variant.table_name} v ON l.variant_id = v.id
          WHERE u.key_type = '%s'
            %s
            AND l.%s IS NOT NULL
            AND l.%s != ''
          GROUP BY u.id
          ORDER BY use_count DESC
          LIMIT 10
        }, key, key, key, landing_query(landing_id), key, key
      ]
    )
  end

  private

  def no_column?(key)
    !Lead::UTM_FIELDS.include? key.to_sym
  end

  def exec_query(query)
    ActiveRecord::Base.connection.execute(sanitize(query))
                      .to_a.map(&:symbolize_keys)
  end

  def sanitize(query)
    ActiveRecord::Base.send(:sanitize_sql_array, query)
  end

  def landing_query(landing_id)
    landing_id ? sanitize(['AND v.landing_id = %d', landing_id]) : ''
  end
end
