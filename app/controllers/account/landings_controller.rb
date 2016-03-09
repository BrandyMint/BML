class Account::LandingsController < Account::BaseController
  layout 'account'

  helper_method :current_landing

  def index
    render locals: { landings: landings }
  end

  def new
    render locals: { landing: build_landing }, layout: 'account_middle'
  end

  def edit
    render locals: { landing: current_landing }, layout: 'landing'
  end

  def show
    redirect_to account_landing_leads_path(params[:id])
  end

  def create
    landing = create_landing!
    redirect_to account_landing_editor_path landing.default_variant.uuid
  rescue ActiveRecord::RecordInvalid => err
    render 'new', locals: { landing: err.record }
  end

  def update
    current_landing.update_attributes! permitted_params
    redirect_to edit_account_landing_path current_landing
  rescue ActiveRecord::RecordInvalid
    render 'edit', locals: { landing: err.record }
  end

  private

  def current_variant
    nil
  end

  def build_landing
    current_account.landings.build
  end

  def current_landing
    fail 'No landing_id in param' unless params[:id]
    current_account.landings.find params[:id]
  end

  def landings
    current_account.landings.ordered
  end

  def permitted_params
    params.require(:landing).permit(:title, :path, :head_title, :meta_keywords, :meta_description)
  end

  def create_landing!
    landing = build_landing
    landing.assign_attributes permitted_params
    landing.save!
    v = landing.variants.create!
    SectionsUpdater.new(v, regenerate_uuid: true).update(LandingExamples::EXAMPLE1)

    landing
  end
end
