class AddCoverUvSensorToWorkPermits < ActiveRecord::Migration[7.0]
  def change
    add_column :work_permits, :cover_uv_sensor, :boolean
  end
end
