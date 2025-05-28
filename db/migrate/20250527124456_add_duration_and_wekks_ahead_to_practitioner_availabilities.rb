class AddDurationAndWekksAheadToPractitionerAvailabilities < ActiveRecord::Migration[8.0]
  def change
    add_column :practitioner_availabilities, :slot_duration_minutes, :integer, default: 30, null: false
    add_column :practitioner_availabilities, :weeks_ahead, :integer, default: 4, null: false
  end
end
