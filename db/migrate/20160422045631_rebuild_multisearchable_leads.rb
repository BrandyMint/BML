class RebuildMultisearchableLeads < ActiveRecord::Migration
  def change
    PgSearch::Multisearch.rebuild(Lead)
  end
end
