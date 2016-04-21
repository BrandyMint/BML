module SectionDataBuilder
  BUILDERS = {
    LeaderBoard: LeaderBoard::CommonBuilder
  }.freeze

  def data
    return unless source_collection.present?

    builder_class = BUILDERS[block_view.to_sym]
    return unless builder_class.present?

    builder_class.new(collection: source_collection).build
  end

  private

  def source_collection
    @_source_collection = find_source_collection || default_source_collection
  end

  def default_source_collection
    landing.default_records_collection if block_view == 'LeaderBoard'
  end

  def find_source_collection
    return unless source_collection_uuid.present?

    collection = landing.collections.find_by_uuid source_collection_uuid
    unless collection.present?
      Bugsnag.notify "No collection #{source_collection_uuid} for section #{uuid} in variant #{variant.uuid}"
      return
    end

    collection
  end

  def source_collection_uuid
    content['source_collection_uuid']
  end
end
