class AddAvatarFieldToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :avatar, :string
  end
end
