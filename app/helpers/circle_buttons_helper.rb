module CircleButtonsHelper
  def smart_polymorphic_url(url, args = {})
    args.reverse_merge! action: :edit
    case url
    when ActiveRecord::Base
      resource = [:account, url]
      polymorphic_path resource, args
    when String
      url
    else
      raise "Unknown url type: #{url}"
    end
  end

  # Circle Buttons
  def show_button_circle(url, icon: :desktop, css_class: nil, title: I18n.t('shared.show'), method: :get)
    link_to smart_polymorphic_url(url), class: "btn btn-secondary btn-circle #{css_class}", tooltip: true, title: title, method: method do
      fa_icon icon
    end
  end

  def images_button_circle(url)
    show_button_circle url, icon: :image, title: 'Изображения'
  end

  def smart_edit_button_circle(resource)
    if resource.alive?
      edit_button_circle resource
    else
      show_button_circle resource
    end
  end

  def edit_button_circle(url)
    link_to smart_polymorphic_url(url), class: 'btn btn-secondary btn-circle', tooltip: true, title: I18n.t('shared.edit') do
      fa_icon 'pencil'
    end
  end

  def add_button_circle(url, title: nil)
    title ||= t('shared.add')

    # scope association
    #
    url = url.new if url.respond_to? :new
    url = polymorphic_path([:operator, url], action: :new) if url.is_a? ActiveRecord::Base
    link_to url, class: 'btn btn-primary btn-circle', tooltip: true, title: title do
      fa_icon 'plus'
    end
  end

  def share_button_circle(url)
    url = polymorphic_path([:operator, url]) if url.is_a? ActiveRecord::Base
    link_to fa_icon('external-link'), url,
            target: :_blank,
            class: 'btn btn-secondary btn-circle'
  end

  def ignore_button_circle(path)
    link_to operator_not_found_path(path, response_state: :ignore),
            class: 'btn btn-circle btn-secondary',
            title: 'Игнорировать',
            tooltip: true,
            method: :patch do
      fa_icon 'legal'
    end
  end

  def make_redirect_button_circle(path)
    link_to new_operator_slug_redirect_path(slug_redirect: { path: path.path }, backurl: request.path),
            title: 'Сделать редирект',
            tooltip: true,
            class: 'btn btn-circle btn-primary' do
      fa_icon 'mail-forward'
    end
  end

  def smart_archive_button_circle(resource)
    if resource.alive?
      archive_button_circle resource if Pundit.policy(current_member, resource).destroy?
    elsif Pundit.policy(current_member, resource).update?
      restore_button_circle resource
    end
  end

  def archive_button_circle(url, confirm = nil)
    title = t('shared.archive')
    url = smart_polymorphic_url(url, action: :archive) if url.is_a? ActiveRecord::Base
    confirm ||= t('shared.archive_confirm')
    link_to(
      url,
      class: 'btn btn-circle btn-danger',
      method: :delete,
      tooltip: true,
      title: title,
      data: { confirm: confirm }
    ) do
      fa_icon :trash
    end
  end

  def restore_button_circle(url)
    url = smart_polymorphic_url(url, action: :restore) if url.is_a? ActiveRecord::Base
    link_to(
      url,
      class: 'btn btn-circle btn-warning',
      tooltip: true,
      title: t('shared.restore'),
      method: :post
    ) do
      fa_icon :refresh
    end
  end

  def delete_button_circle(url, confirm = nil)
    title = t('shared.delete')
    confirm ||= t('shared.delete_confirm')
    link_to(
      smart_polymorphic_url(url, action: nil),
      class: 'btn btn-circle btn-danger',
      method: :delete,
      tooltip: true,
      title: title,
      data: { confirm: confirm }
    ) do
      fa_icon 'times'
    end
  end

  def toggle_state_button_circle(model)
    on_path = send("activate_operator_#{model.class.model_name.singular}_path", model)
    off_path = send("deactivate_operator_#{model.class.model_name.singular}_path", model)
    if model.is_active?
      eye_icon off_path
    else
      eye_slash_icon on_path
    end
  end

  def eye_icon(path)
    link_to(
      path,
      method: :post,
      class: 'btn btn-secondary btn-circle',
      tooltip: true,
      title: I18n.t('shared.is_on') + '. ' + I18n.t('shared.action_turn_off')
    ) do
      fa_icon 'eye'
    end
  end

  def eye_slash_icon(path)
    link_to(
      path,
      method: :post,
      class: 'btn btn-secondary btn-circle',
      tooltip: true,
      title: I18n.t('shared.is_off') + '. ' + I18n.t('shared.action_turn_on')
    ) do
      fa_icon 'eye-slash'
    end
  end
end
