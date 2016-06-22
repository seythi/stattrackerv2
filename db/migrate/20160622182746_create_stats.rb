class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :label
      t.integer :value
      t.string :conts
      t.boolean :dmonly
      t.references :pc, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
