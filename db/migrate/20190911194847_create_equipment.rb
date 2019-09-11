class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.string :brand
      t.string :description, null: false
      t.string :pic_url
      t.boolean :available, default: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
