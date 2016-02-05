module EmailUtils
  def self.clean_email(email)
    email.to_s.downcase.strip.chomp
  end
end
