class AddUniqueIndexToSlots < ActiveRecord::Migration[8.0]
  def change
    add_index :slots, [ :practitioner_availability_id, :start_time, :end_time ], unique: true, name: "index_slots_on_availability_and_time"
  end
end
