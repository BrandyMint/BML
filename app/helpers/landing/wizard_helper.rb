class Landing
  module WizardHelper
    def wizard_question_title(question, answered_keys)
      "#{question.text} #{wizard_question_answered_icon(question, answered_keys)}".html_safe
    end

    def wizard_question_answered_icon(question, answered_keys)
      return unless answered_keys.include? question.key
      fa_icon 'check', class: 'pull-right m-t-sm'
    end
  end
end
