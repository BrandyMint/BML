class SectionsUpdater
  def initialize(variant, regenerate_uuid: false)
    @variant = variant
    @regenerate_uuid = regenerate_uuid
  end

  def update(raw_data)
    raw_data = Hashie::Mash.new raw_data
    Section.transaction do
      update_blocks raw_data['blocks'] if raw_data['blocks'].is_a? Array
    end
  end

  private

  attr_reader :raw_data, :variant, :regenerate_uuid

  def update_blocks(blocks)
    variant.lock!

    uuids = []
    blocks.each_with_index do |block, index|
      block['uuid'] = UUID.generate if regenerate_uuid

      uuids << block['uuid']
      SectionUpdater
        .new(variant: variant, block: block)
        .update index
    end

    variant
      .sections
      .where.not(uuid: [uuids])
      .delete_all

    variant.update_columns sections_count: blocks.count, updated_at: Time.now
  end
end
