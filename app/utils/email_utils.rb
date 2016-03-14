module EmailUtils
  def clean_email(email)
    email.to_s.downcase.strip.chomp
  end

  module_function :clean_email
end
