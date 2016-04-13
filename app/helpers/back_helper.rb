module BackHelper
  def backurl
    params[:backurl]
  end

  def backlink
    return unless backurl
    link_to "&larr; Назад".html_safe, backurl
  end

  def backbutton
    return unless backurl
    link_to backurl, class: 'btn btn-secondary' do
      fa_icon :backward, text: 'Назад', class: 'm-r-sm'
    end
  end

  def hidden_backurl_field(_f)
    hidden_field_tag :backurl, backurl
  end
end
