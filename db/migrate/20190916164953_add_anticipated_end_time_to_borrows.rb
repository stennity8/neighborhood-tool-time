class AddAnticipatedEndTimeToBorrows < ActiveRecord::Migration[6.0]
  def change
    add_column :borrows, :anticipated_end_time, :datetime
  end
end
