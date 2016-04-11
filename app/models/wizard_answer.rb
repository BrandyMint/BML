class WizardAnswer < ActiveRecord::Base
  belongs_to :landing
  has_many :asset_files, dependent: :destroy
  has_many :asset_images

  scope :completed, -> { where completed: true }

  before_save :set_completed_state

  def question
    @_question ||= Wizard::QuestionList.new(landing).find question_key
  end

  def to_param
    question_key
  end

  def complete
    update_columns completed: true
  end

  private

  def set_completed_state
    return unless text.present?
    self.completed = true
  end
end
