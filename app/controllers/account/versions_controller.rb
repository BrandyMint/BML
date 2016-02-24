class Account::VersionsController < Landing::BaseController
  layout 'landing'

  def update
    version.update_attributes! permitted_params
    redirect_to account_landing_versions_path(current_landing)
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { version: err.record }
  end

  def edit
    render locals: { version: version }
  end

  def new
    render locals: { version: build_version }
  end

  def create
    version = build_version
    version.assign_attributes permitted_params
    version.save!
    redirect_to account_landing_versions_path(current_landing)
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { version: err.record }
  end

  def index
    render locals: { versions: versions }
  end

  private

  def build_version
    current_landing.versions.build
  end

  def versions
    current_landing.versions.ordered
  end

  def version
    @_version ||= current_landing.versions.find params[:id]
  end

  def permitted_params
    params.require(:landing_version).permit(:title)
  end
end
