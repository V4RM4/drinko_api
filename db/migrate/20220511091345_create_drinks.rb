class CreateDrinks < ActiveRecord::Migration[7.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :category
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
