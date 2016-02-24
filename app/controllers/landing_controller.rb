class LandingController < ApplicationController
  include CurrentLanding

  layout 'public'

  def show
    data = Entities::LandingVersionEntity.represent(current_landing_version).as_json
    render locals: {
      state: {
        application: {
          landingVersionUuid: current_landing_version.uuid
        },
        blocks: data[:sections]
      },
      current_landing: current_landing_version.landing
    }
  end
end
