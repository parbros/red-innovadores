class AddFieldsToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :gender, :string
    add_column :refinery_users, :age_range, :integer
  end
end
