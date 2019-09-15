class CreateBorrows < ActiveRecord::Migration[6.0]
  def change
    create_table :borrows do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.boolean :returned, default: false
      t.references :user, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
