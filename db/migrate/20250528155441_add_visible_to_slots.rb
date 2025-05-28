class AddVisibleToSlots < ActiveRecord::Migration[8.0]
  def change
    add_column :slots, :visible, :boolean
  end
end
