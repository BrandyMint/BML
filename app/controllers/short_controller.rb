class ShortController < ApplicationController
  def show
    url = ShortUrl.find_short params[:id]
    raise ActiveRecord::RecordNotFound unless url.present?

    redirect_to url
  end
end
