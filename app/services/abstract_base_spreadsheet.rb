class AbstractBaseSpreadsheet
  DEFAULT_ENCODING = 'cp1251'.freeze

  # :col_sep ","
  # :row_sep :auto
  # :quote_char '"'
  # :field_size_limit nil
  # :converters nil
  # :unconverted_fields nil
  # :headers false
  # :return_headers false
  # :header_converters nil
  # :skip_blanks false
  # :force_quotes false
  # :skip_lines nil
  #
  CSV_OPTIONS = { col_sep: ';' }.freeze

  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def to_csv
    converter = lambda do |s|
      return s unless s.is_a? String
      encoding.present? ? s.encode(encoding) : s
    end
    CSV.generate(CSV_OPTIONS) do |csv|
      csv << header_row.map(&converter)
      collection.find_in_batches do |batch|
        batch.each do |item|
          csv << row(item).map(&converter)
        end
      end
    end
  end

  private

  def encoding
    DEFAULT_ENCODING
  end

  def header_row
    'not implemented'
  end

  def row(_item)
    'not implemented'
  end
end
