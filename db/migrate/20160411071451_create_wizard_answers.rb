class CreateWizardAnswers < ActiveRecord::Migration
  def change
    create_table :wizard_answers do |t|
      t.belongs_to :landing, index: true, foreign_key: true, null: false
      t.string :wizard_key, null: false
      t.string :question_key, null: false
      t.text :text
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end

    add_index :wizard_answers, [:question_key, :wizard_key], unique: true
  end
end
