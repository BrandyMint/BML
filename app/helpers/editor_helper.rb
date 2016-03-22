module EditorHelper
  def bugsnag_editor_data
    bugsnag_user current_user.as_json(only: [:id, :name, :email, :phone])
  end
end
