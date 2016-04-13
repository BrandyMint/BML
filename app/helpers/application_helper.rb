module ApplicationHelper
  def format_uuid(uuid)
    content_tag :div, class: 'text-muted text-nowrap' do
      content_tag :small do
        "UUID: #{uuid}"
      end
    end
  end

  def utm_fields_only
    TrackingSupport::UTM_FIELD_DEFINITIONS.reject { |i| i.key == :referer }
  end

  def empty_value
    '&middot;'.html_safe
  end

  def unknown_value_html
    content_tag :span, '?', class: 'text-muted'
  end

  def empty_value_html
    content_tag :span, empty_value, class: 'text-muted'
  end

  def setup_editor_bml
    config = {
      postLeadUrl: post_lead_url,
      apiUrl: api_v1_url,
      apiKey: current_account.api_key,
      variantUuid: current_variant.uuid,
      exitUrl: editor_exit_url
    }
    javascript_tag "window.bmlConfig = #{config.to_json}"
  end

  def editor_exit_url
    backurl || landing_leads_url(current_variant.landing_id)
  end

  def api_v1_url
    url = api_url.include?('localhost') ? api2_url : api_url
    url + 'v1'
  end

  def post_lead_url
    leads_url subdomain: ''
  end

  def paginate(objects, options = {})
    options.reverse_merge! theme: 'twitter-bootstrap-4'
    super objects, options
  end

  def omniauth_button(provider, title: nil)
    # link_to "/auth/#{provider}/?account_signature=#{account_signature}", class: 'btn btn-success btn-rounded' do
    link_to "/auth/#{provider}", class: 'btn btn-success btn-rounded' do
      fa_icon provider, text: title || t(provider, scope: 'operator.omniauth_buttons')
    end
  end
end
