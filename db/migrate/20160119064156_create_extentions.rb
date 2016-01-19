class CreateExtentions < ActiveRecord::Migration
  def up
    enable_extension "hstore"
  end
end
