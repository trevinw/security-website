class CreateHazardsWorkPermits < ActiveRecord::Migration[7.0]
  def change
    create_table :hazards_work_permits do |t|
      t.belongs_to :hazard
      t.belongs_to :work_permit

      t.timestamps
    end
  end
end
