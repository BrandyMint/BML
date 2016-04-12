# encoding: utf-8
module Account::PaymentsHelper
  def expire_months_as_options
    (1..12).map { |m| (m > 9 ? m : "0#{m}").to_s }
  end

  def expire_years_as_options
    year = Time.current.year
    year..(year + 25)
  end

  def payment_account_card(account)
    buf = ''
    buf << fa_icon("cc-#{account.card_type.downcase}", class: 'm-r-md fa-2x')
    buf << content_tag(:span, "#{account.card_first_six} ✱✱ ✱✱✱✱ #{account.card_last_four}", class: 'm-r-md')
    buf << content_tag(:span, account.card_exp_date)
    buf
  end
end
