class AddBypassOzoneToWorkPermits < ActiveRecord::Migration[7.0]
  def change
    add_column :work_permits, :bypass_ozone, :boolean
  end
end
