class Landing::VariantsController < Landing::BaseController
  layout 'landing_settings'

  def update
    variant.update_attributes! permitted_params
    redirect_to landing_variants_path(current_landing)
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { variant: err.record }
  rescue JSON::ParserError => err
    variant.errors[:data] = err.message.force_encoding('utf-8')
    render 'edit', locals: { variant: variant }
  end

  def edit
    render locals: { variant: variant }
  end

  def new
    render locals: { variant: build_variant }
  end

  def create
    variant = build_variant
    variant.assign_attributes permitted_params
    variant.save!
    redirect_to account_variants_path(current_landing)
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { variant: err.record }
  end

  def deactivate
    variant.deactivate!
    redirect_to :back
  end

  def activate
    variant.activate!
    redirect_to :back
  end

  def index
    render locals: { variants: variants }
  end

  def destroy
    variant.deactivate!
    redirect_to :back
  end

  private

  def build_variant
    current_landing.variants.build
  end

  def variants
    current_landing.variants.ordered
  end

  def variant
    @_variant ||= current_landing.variants.find params[:id]
  end

  def permitted_params
    params.require(:variant).permit(:title, :data)
  end
end
