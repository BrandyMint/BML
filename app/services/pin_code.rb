# Генерирует пин-код
module PinCode
  def self.generate(length = 6)
    SecureRandom.hex length / 2
  end
end
