class CreateStageItems < ActiveRecord::Migration
  def change
    create_table :stage_items do |t|
      t.integer :item_type
      t.integer :phase
      t.string :x
      t.string :integer
      t.integer :y

      t.timestamps null: false
    end
  end
end
