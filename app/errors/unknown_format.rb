class UnknownFormat < StandardError
  def http_status
    415
  end
end
