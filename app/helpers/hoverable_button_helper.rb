module HoverableButtonHelper
  OFF_CLASSES = 'btn btn-outline btn-warning btn-sm'
  ON_CLASSES  = 'btn btn-success btn-sm'

  ON_ICON     = :check
  OFF_ICON    = :ban

  def hoverable_on_button(url, title:, hover_title:, method: nil, icon: nil, hover_icon: nil, disable_with: nil)
    hoverable_button(
      url,
      title:         title,
      classes:       ON_CLASSES,
      hover_classes: OFF_CLASSES,
      hover_title:   hover_title,
      icon:          icon || ON_ICON,
      hover_icon:    hover_icon || OFF_ICON,
      disable_with:  disable_with || t(:making_off, scope: [:operator, :toggle_buttons, :disable_with])
    )
  end

  def hoverable_off_button(url, title:, hover_title:, method: nil, icon: nil, hover_icon: nil, disable_with: nil)
    hoverable_button(
      url,
      title:         title,
      classes:       OFF_CLASSES,
      hover_classes: ON_CLASSES,
      hover_title:   hover_title,
      icon:          icon || OFF_ICON,
      hover_icon:    hover_icon || ON_ICON,
      disable_with:  disable_with || t(:making_on, scope: [:operator, :toggle_buttons, :disable_with])
    )
  end

  def hoverable_button(url, method: :patch, title:, hover_title:, classes:, hover_classes:, icon:, hover_icon:, disable_with: nil)
    rehover = {
      hover: { title: hover_title, class: hover_classes, icon: hover_icon }
    }
    opts = { data: { 'disable-with' => disable_with, rehover: rehover }, class: classes }
    opts[:method] = method unless method.to_s.upcase == 'GET'
    link_to url, opts do
      fa_icon icon, text: title
    end
  end

  #def button
    #link_to(
      #I18n.t('shared.is_on'),
      #off_path,
      #method: :post,
      #class: 'btn btn-rounded btn-success btn-sm btn-toggle btn-outline active',
      #data: { 'hover-text' => I18n.t('shared.turn_off') }
    #)
  #end
end
