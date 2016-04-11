class Landing::WizardAnswersController < Landing::BaseController
  layout 'wizard'

  # TODO: брать из типа лендоса
  WIZARD_KEY = YAML.load_file(Rails.root.join('config/wizards.yml'))['wizards'].first

  delegate :wizard_answers, to: :current_landing
  delegate :questions, to: :question_list

  def index
    question = if question_list.completed?(current_landing)
                 questions.first
               else
                 question_list.first_empty(current_landing)
               end

    redirect_to landing_wizard_answer_path(current_landing, question.key)
  end

  def show
    render locals: { questions: questions,
                     answered_keys: answered_keys,
                     current_question: current_question,
                     current_answer: current_answer }
  end

  def update
    current_answer.update! permitted_params
    success_redirect

  rescue ActiveRecord::RecordInvalid => err
    render :show, locals: { questions: questions,
                            answered_keys: answered_keys,
                            current_question: current_question,
                            current_answer: err.record }
  end

  private

  def answer_params
    {
      **permitted_params,
      wizard_key: WIZARD_KEY,
      question_key: current_question.key
    }
  end

  def success_redirect
    if question_list.completed?(current_landing)
      redirect_to landing_path(current_landing), flash: { success: I18n.t('services.wizard.completed') }
    else
      redirect_to landing_wizard_answer_path(current_landing, question_list.next(current_question).key)
    end
  end

  def current_question
    @_current_question ||= question_list.find params[:id]
  end

  def current_answer
    @_current_answer ||= find_or_create_answer
  end

  def answered_keys
    answers.completed.pluck :question_key
  end

  def find_or_create_answer
    answer = answers.where(question_key: current_question.key).first
    answer.presence || wizard_answers.create!(wizard_key: WIZARD_KEY, question_key: current_question.key)
  end

  def answers
    wizard_answers.where(wizard_key: WIZARD_KEY)
  end

  def question_list
    @_questions ||= Wizard::QuestionList.new(WIZARD_KEY)
  end

  def permitted_params
    params.require(:wizard_answer).permit(:text)
  rescue
    {}
  end
end
