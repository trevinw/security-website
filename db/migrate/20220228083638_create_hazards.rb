class CreateHazards < ActiveRecord::Migration[7.0]
  def change
    create_table :hazards do |t|
      t.string :name

      t.timestamps
    end
  end
end
