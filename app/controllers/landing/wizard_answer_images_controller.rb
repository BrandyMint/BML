class Landing::WizardAnswerImagesController < Landing::BaseController
  def create
    new_image = answer.asset_images.build file: params[:answer_image]
    image = answer.asset_images.find_by_digest new_image.file.digest

    unless image
      new_image.save!
      answer.complete
    end

    head 201
  rescue ActiveRecord::RecordInvalid => err
    render json: { error: err.message }, status: 400
  end

  def destroy
    image.destroy!
    redirect_to :back
  end

  private

  def image
    answer.asset_images.find params[:id]
  end

  def answer
    current_landing.wizard_answers.find_by_question_key params[:wizard_answer_id]
  end
end
