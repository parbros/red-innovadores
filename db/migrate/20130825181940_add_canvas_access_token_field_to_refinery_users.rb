class AddCanvasAccessTokenFieldToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :canvas_access_token, :string
  end
end
