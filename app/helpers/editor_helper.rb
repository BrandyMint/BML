module EditorHelper
  def bugsnag_editor_data
    bugsnag_user(current_user.as_json(only: [:id, :name, :email, :phone])) +
      bugsnag_metadata(
        account: current_account.as_json(only: [:id], methods: [:title]),
        variant: current_variant.as_json(only: [:uuid, :landing_id, :updated_at])
      )
  end
end
