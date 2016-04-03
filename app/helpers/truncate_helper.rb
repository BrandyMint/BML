module TruncateHelper
  Text = Importer.import ActionView::Helpers::TextHelper

  def truncate_middle(buffer, length: 30, finish: 7)
    Text.truncate buffer, length: length, omission: "...#{buffer[-finish, finish]}"
  end
end
