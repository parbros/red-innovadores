class AddRemoteEnrollIdToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :remote_enroll_id, :integer
  end
end
