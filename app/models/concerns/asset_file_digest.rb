require 'digest'

module AssetFileDigest
  extend ActiveSupport::Concern

  included do
    before_create :build_digest
  end

  def self.digest_of_file(file)
    Digest::SHA256.file(file)
      .hexdigest
  end

  private

  def build_digest
    self.digest =
      AssetFileDigest.digest_of_file(file.file.file)

    self.file_size =
      File.size file.file.file
  end
end
