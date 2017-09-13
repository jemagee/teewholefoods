class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :number, limit: 8

      t.timestamps
    end
  end
end
