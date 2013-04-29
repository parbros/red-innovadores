class AddCountryCodeToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :country_code, :string
  end
end
