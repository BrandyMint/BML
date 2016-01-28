class AssetImageUploader < ImageUploader
  def store_dir
    "uploads/shop/#{model.vendor_id}/images"
  end
end
