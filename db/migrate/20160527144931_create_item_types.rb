class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.integer :phase_count
      t.string :name

      t.timestamps null: false
    end
  end
end
