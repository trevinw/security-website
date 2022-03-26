class CreateBuildingsWorkPermits < ActiveRecord::Migration[7.0]
  def change
    create_table :buildings_work_permits do |t|
      t.belongs_to :building
      t.belongs_to :work_permit

      t.timestamps
    end
  end
end
