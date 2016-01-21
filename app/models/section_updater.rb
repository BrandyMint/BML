class SectionUpdater
  def initialize(landing_version:, data:, block:)
    @landing_version = landing_version
    @data            = data
    @block           = block
  end

  def update(position)
    section.assign_attributes(
      'row_order' =>  position,
      'block_type' => block['type'],
      'block_view' => block['view']
    )
    section.save!
  end

  private

  attr_reader :landing_version, :data, :block

  def uuid
    block['uuid'] || fail('No uuid in block')
  end

  def section
    @_section ||=
      landing_version
      .sections
      .find_or_initialize_by uuid: uuid
  end
end
