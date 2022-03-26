class CreateWorkPermits < ActiveRecord::Migration[7.0]
  def change
    create_table :work_permits do |t|
      t.integer :number
      t.string :status
      t.string :work_location
      t.text :work_description
      t.text :notes
      t.date :start_date
      t.date :end_date
      t.string :category
      t.boolean :needs_bypass
      t.string :seh_representative
      t.string :alternative_contact

      t.belongs_to :company, index: true, foreign_key: true

      t.timestamps
    end
  end
end
