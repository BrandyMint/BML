class SectionUpdater
  BACKGROUND_KEYS = %i(color position attachment repeat)

  def initialize(variant:, block:)
    @variant = variant
    @block           = block
  end

  def update(position)
    section.assign_attributes(
      'row_order'       => position,
      'content'         => block['content'],
      'form'            => block['form'],
      'block_view'      => block['viewName'],
      'node_attributes' => block['nodeAttributes'] || {},
      'background_attributes' => (block['background'] || {}).slice(BACKGROUND_KEYS),
      'background_image' => background_image
    )
    section.save!
  end

  private

  attr_reader :variant, :block

  delegate :account, to: :variant

  def background_image
    image = block['backgroundImage']

    return nil unless image.is_a? Hash

    if image['uuid'].present?
      AssetImage.find_by_uuid image['uuid']

    elsif image['url'].present?
      raise 'Dont use .. in url' if image['url'].include? '..'

      if image['url'].start_with? '/'
        filename = Rails.root.join 'vendor/dist/src' + image['url']
        digest = AssetFileDigest.digest_of_file filename

        AssetFile.shared.find_by_digest(digest) ||
          account.asset_images.find_by_digest(digest) ||
          account.asset_images.create!(file: filename.open)
      else
        # TODO Сохранять прямые ссыслки
      end
    else
      nil
    end
  end

  def uuid
    block['uuid'] || fail('No uuid in block')
  end

  def section
    @_section ||=
      variant
      .sections
      .find_or_initialize_by uuid: uuid
  end
end
