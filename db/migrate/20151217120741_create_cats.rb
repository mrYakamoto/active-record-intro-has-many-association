class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string  :name
      t.boolean :has_bell
      t.integer :age
      t.string :color

      t.timestamps(null: false)
    end
  end
end
