class SectionsUpdater
  def initialize(landing_version, raw_data)
    @landing_version = landing_version
    @raw_data = Hashie::Mash.new raw_data
  end

  def update
    Section.transaction do
      landing_version.lock!
      section_ids = landing_version.sections.pluck(:id)

      blocks.each_with_index do |block, index|
        uuid = block['uuid']
        block_data = data[uuid] or fail "No data for uuid #{uuid}"

        block['uuid'] = UUID.generate if regenerate_uuid

        SectionUpdater
          .new(landing_version: landing_version, data: block_data, block: block)
          .update index
      end

      landing_version.sections.where(id: section_ids).delete_all
      landing_version.update_columns sections_count: blocks.count, updated_at: Time.now
    end
  end

  private

  attr_reader :raw_data, :landing_version

  delegate :data, :blocks, :regenerate_uuid, to: :raw_data
end
