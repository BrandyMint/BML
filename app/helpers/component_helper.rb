module ComponentHelper
  def site_landing_component(_landing)
    react_component 'LPage', LandingExamples::EXAMPLE1
  rescue => err
    err.message
  end

  def editor_component
    react_component 'LPage', LandingExamples::EXAMPLE1
  rescue => err
    err.message
  end
end
