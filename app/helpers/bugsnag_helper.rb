module BugsnagHelper
  def bugsnag_script
    javascript_include_tag(
      '//d2wy8f7a9ursnm.cloudfront.net/bugsnag-2.min.js',
      data: {
        apikey: Bugsnag.configuration.api_key,
        appversion: AppVersion.to_s,
        releasestage: Rails.env
      }
    )
  end

  def bugsnag_user(user)
    javascript_tag "document.addEventListener(\"DOMContentLoaded\", function(event) { Bugsnag.user = #{user.to_json}; });"
  end

  def bugsnag_metadata(data)
    # TODO: Если metaData уже есть, добавлять к ней
    javascript_tag "document.addEventListener(\"DOMContentLoaded\", function(event) { Bugsnag.metaData = #{data.to_json}; });"
  end
end
