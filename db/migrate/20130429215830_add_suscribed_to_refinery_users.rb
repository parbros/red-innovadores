class AddSuscribedToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :suscribed, :boolean
  end
end
