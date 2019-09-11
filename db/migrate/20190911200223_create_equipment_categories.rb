class CreateEquipmentCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment_categories do |t|
      t.references :equipment, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
