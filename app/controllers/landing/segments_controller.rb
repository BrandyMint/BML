class Landing::SegmentsController < Landing::BaseController
  layout 'analytics'

  def index
    render locals: { segments: segments }
  end

  def new
    render locals: { segment: build_segment }
  end

  def create
    segment = build_segment
    segment.assign_attributes permitted_params
    segment.save!
    redirect_to landing_segments_path(current_landing)
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { segment: err.record }
  end

  private

  def build_segment
    current_landing.segments.build
  end

  def segments
    current_landing.segments.ordered
  end

  def segment
    @_segment ||= current_landing.segments.find params[:id]
  end

  def permitted_params
    params.require(:segment).permit(:title)
  end
end
