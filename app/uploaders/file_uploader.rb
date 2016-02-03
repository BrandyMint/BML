class FileUploader < BaseUploader
  include ActionView::Helpers::NumberHelper

  def extension
    File.extname file.filename if file.present?
  end

  def details
    "#{number_to_human_size file.size} #{extension}"
  end

  def digest
    AssetFileDigest.digest_of_file file.file
  end
end
