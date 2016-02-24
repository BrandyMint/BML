class AddSubdomainFoAccounts < ActiveRecord::Migration
  def change
    Account.find_each do |a|
      a.create_subdomain! subdomain: a.ident
    end
  end
end
