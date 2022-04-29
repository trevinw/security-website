class RenameNeedsBypassOnWorkPermits < ActiveRecord::Migration[7.0]
  def change
    rename_column :work_permits, :needs_bypass, :bypass_building
  end
end
