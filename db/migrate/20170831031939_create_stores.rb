class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.belongs_to :region, foreign_key: true
      t.boolean :open, default: true
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end
