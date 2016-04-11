class AddWizardAnswerToAssetFiles < ActiveRecord::Migration
  def change
    add_reference :asset_files, :wizard_answer, index: true, foreign_key: true
  end
end
