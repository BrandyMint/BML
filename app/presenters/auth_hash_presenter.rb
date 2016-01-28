class AuthHashPresenter < BasePresenter
  def nickname
    raw_info.screen_name || info.nickname || info.name.parameterize
  end

  def username
    info.name
  rescue
    '-'
  end

  def email
    info['email']
  end

  def url
    raw_info.url
  rescue
    nil
  end

  # У W1 есть
  def expires_at
    Time.zone.parse self['credentials']['expires']
  rescue StandardError
    nil
  end

  def expired?
    expires_at < Time.current
  end

  def avatar_url
    # vkontakte
    raw_info.photo_200_orig || raw_info.photo_100 || info.image
  rescue
    nil
  end

  def uid
    self['uid'].to_s
  end

  def provider
    self['provider'].to_sym
  end

  def access_token
    self['credentials'].fetch('token', nil)
  end

  private

  attr_reader :auth_hash

  def info
    @info ||= OpenStruct.new self['info']
  end

  def raw_info
    @raw_info ||= OpenStruct.new(self['extra']['raw_info'] || {})
  end
end
