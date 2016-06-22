class CreatePcs < ActiveRecord::Migration
  def change
    create_table :pcs do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :campaign, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
