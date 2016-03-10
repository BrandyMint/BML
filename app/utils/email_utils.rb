module EmailUtils
  extend self

  def clean_email(email)
    email.to_s.downcase.strip.chomp
  end
end
