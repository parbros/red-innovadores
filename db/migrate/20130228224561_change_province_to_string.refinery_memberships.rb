# This migration comes from refinery_memberships (originally 20120919125923)
class ChangeProvinceToString < ActiveRecord::Migration

  def self.up
    change_column Refinery::User.table_name, :province, :string
  end

  def self.down
    change_column Refinery::User.table_name, :province, :integer
  end

end
