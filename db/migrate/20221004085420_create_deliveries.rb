class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.datetime :datetime
      t.string :company
      t.string :category
      t.string :destination
      t.boolean :chemical_delivery
      t.string :chemical_type
      t.string :seh_contact
      t.text :notes

      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
