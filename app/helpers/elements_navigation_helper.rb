module ElementsNavigationHelper
  MENU = {
    Invite => [:delete],
    Membership => [:edit, :delete]
  }.freeze

  def element_navigation(element)
    content_tag :nav, class: 'horizontal text-nowrap' do
      content_tag :ul, class: 'list-inline' do
        element_navigation_menu element
      end
    end
  end

  private

  ITEM_BUTTONS = {
    show:          :show_button_circle,
    images:        :images_button_circle,
    edit:          :edit_button_circle,
    smart_edit:    :smart_edit_button_circle,
    delete:        :delete_button_circle,
    archive:       :smart_archive_button_circle,
    activity:      :toggle_state_button_circle,
    ignore:        :ignore_button_circle,
    make_redirect: :make_redirect_button_circle
  }.freeze

  def element_navigation_menu(element)
    list = get_menu element.class

    list.map do |item|
      element_navigation_menu_item element, item if authorized_for_menu_item?(element, item)
    end.join('').html_safe
  end

  def authorized_for_menu_item?(element, item)
    return unless element_policy(element)
    case item
    when :show
      element_policy(element).show?
    when :edit
      element_policy(element).update?
    when :delete
      element_policy(element).destroy?
    else
      true
    end
  end

  def element_navigation_menu_item(element, item)
    button = ITEM_BUTTONS[item] || raise("Unknown menu item #{item}")

    content_tag :li do
      send button, element
    end
  end

  def get_menu(klass)
    menu = MENU[klass]
    return menu if menu.present?

    raise NoMenu if klass == Object
    get_menu klass.superclass
  rescue NoMenu
    raise NoMenu, "Unknown MENU for #{klass}"
  end

  def element_policy(resource)
    Pundit.policy(current_member, resource)
  end

  NoMenu = Class.new StandardError
end
