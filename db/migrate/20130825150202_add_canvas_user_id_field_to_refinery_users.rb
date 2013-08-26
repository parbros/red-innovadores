class AddCanvasUserIdFieldToRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_users, :canvas_user_id, :integer
  end
end
