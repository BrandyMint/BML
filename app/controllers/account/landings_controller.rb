class Account::LandingsController < Account::ApplicationController
  helper_method :current_landing, :current_landing_version

  def index
    render locals: { landings: landings }
  end

  def new
    render locals: { landing: build_landing }
  end

  def edit
    render locals: { landing: current_landing}, layout: 'settings'
  end

  def show
    fail 'not realized'
  end

  def create
    landing = build_landing
    landing.assign_attributes permitted_params
    landing.save!

    redirect_to account_landings_path
  rescue ActiveRecord::RecordInvalid => err
    render 'new', locals: { landing: err.record }, layout: 'landing'
  end

  def update
    current_landing.update_attributes! permitted_params
    redirect_to edit_account_landing_path current_landing
  rescue ActiveRecord::RecordInvalid
    render 'edit', locals: { landing: err.record }, layout: 'settings'
  end

  private

  def current_landing_version
    nil
  end

  def build_landing
    current_account.landings.build
  end

  def current_landing
    current_account.landings.find params[:id]
  end

  def landings
    current_account.landings
  end

  def permitted_params
    params.require(:landing).permit(:title)
  end
end
