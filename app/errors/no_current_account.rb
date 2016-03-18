class NoCurrentAccount < SiteError
  def http_status
    401
  end
end
