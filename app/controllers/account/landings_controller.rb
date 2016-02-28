class Account::LandingsController < Account::BaseController
  layout 'account'

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
    redirect_to account_landing_leads_path(params[:id])
  end

  def create
    landing = create_landing!
    redirect_to landing_editor_path landing.default_version.uuid
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
    fail "No landing_id in param" unless params[:landing_id]
    current_account.landings.find params[:landing_id]
  end

  def landings
    current_account.landings.ordered
  end

  def permitted_params
    params.require(:landing).permit(:title, subdomain_attributes: [:subdomain, :zone, :suggested_domain, :use_domain])
  end

  def create_landing!
    landing = build_landing
    landing.assign_attributes permitted_params
    landing.save!
    v = landing.versions.create!
    SectionsUpdater.new(v, regenerate_uuid: true).update(LandingExamples::EXAMPLE1)

    landing
  end
end
