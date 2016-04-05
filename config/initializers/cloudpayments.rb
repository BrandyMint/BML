if Secrets.cloudpayments.present?
  CloudPayments.configure do |c|
    # c.host = 'http://localhost:3000'    # By default, it is https://api.cloudpayments.ru
    c.public_key = Secrets.cloudpayments.public_key
    c.secret_key = Secrets.cloudpayments.secret_key
    # c.log = false                       # By default. it is true
    c.logger = Logger.new('/dev/null') # By default, it writes logs to stdout
    c.raise_banking_errors = true
  end
end
