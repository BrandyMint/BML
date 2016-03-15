class LeadMailer < BaseMailer
  def new_lead_email(emails, payload)
    @lead = Lead.find payload['lead_id']
    @membership = Membership.find payload['membership_id']
    @data = @lead.data.to_a.map { |d| "#{d[0]}: #{d[1]}" }

    raise NoEmail unless emails.present?

    mail(to: emails,
         subject: I18n.t('mailers.lead_mailer.new_lead_email.subject', public_number: @lead.public_number))
  end
end
