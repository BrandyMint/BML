class AssetImage < AssetFile
  include ImageWithGeometry

  def image
    file
  end
end
