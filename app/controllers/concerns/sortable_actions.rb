module SortableActions
  # ajax request
  def sort
    # у ranked-model позиция начинается с 0
    # а activeadmin-sortable возвращает с 1
    resource.update_attribute :position_position, params[:position].to_i - 1
    head 200
  end

  def up
    resource.move_higher

    success_redirect
  end

  def down
    resource.move_lower

    success_redirect
  end
end
