class Account::LandingsController < Account::ApplicationController
  def index
    render locals: { landings: landings }
  end

  def new
    render locals: { landing: build_landing }
  end

  def edit
    render layout: 'landing'
  end

  def create
    landing = build_landing
    landing.assign_attributes permitted_params
    landing.save!

    redirect_to account_landings_path
  rescue ActiveRecord::RecordInvalid => err
    render 'new', locals: { landing: err.record }
  end

  private

  def build_landing
    current_account.landings.build
  end

  def landings
    current_account.landings
  end

  def permitted_params
    params.require(:landing).permit(:title)
  end
end
