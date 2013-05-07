class AddRegistrationCompletedToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :registration_completed, :boolean
  end
end
