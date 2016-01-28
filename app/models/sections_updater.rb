class SectionsUpdater
  def initialize(landing_version, regenerate_uuid: false)
    @landing_version = landing_version
    @regenerate_uuid = regenerate_uuid
  end

  def update(raw_data)
    raw_data = Hashie::Mash.new raw_data
    Section.transaction do
      update_blocks raw_data['blocks'] if raw_data['blocks'].is_a? Array
    end
  end

  private

  attr_reader :raw_data, :landing_version, :regenerate_uuid

  def update_blocks(blocks)
    landing_version.lock!

    uuids = []
    blocks.each_with_index do |block, index|
      block['uuid'] = UUID.generate if regenerate_uuid

      uuids << block['uuid']
      SectionUpdater
        .new(landing_version: landing_version, block: block)
        .update index
    end

    landing_version
      .sections
      .where.not(uuid: [uuids])
      .delete_all

    landing_version.update_columns sections_count: blocks.count, updated_at: Time.now
  end
end
