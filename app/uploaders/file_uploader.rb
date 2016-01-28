class FileUploader < BaseUploader
  include ActionView::Helpers::NumberHelper

  def extension
    File.extname file.filename if file.present?
  end

  def details
    "#{number_to_human_size file.size} #{extension}"
  end
end
