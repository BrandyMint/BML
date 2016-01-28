class SectionUpdater
  def initialize(landing_version:, block:)
    @landing_version = landing_version
    @block           = block
  end

  def update(position)
    section.assign_attributes(
      'row_order'  => position,
      'data'       => block['data'],
      'block_type' => block['type'],
      'block_view' => block['view']
    )
    section.save!
  end

  private

  attr_reader :landing_version, :block

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
