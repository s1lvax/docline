  class AddWeekdayAndTimeToPractitionerAvailabilities < ActiveRecord::Migration[8.0]
  def change
    # Remove old datetime columns
    remove_column :practitioner_availabilities, :start_time, :datetime
    remove_column :practitioner_availabilities, :end_time, :datetime

    # Add new columns for recurring slots
    add_column :practitioner_availabilities, :weekday, :integer, null: false # 0 = Sunday, 1 = Monday, etc.
    add_column :practitioner_availabilities, :start_time, :time, null: false
    add_column :practitioner_availabilities, :end_time, :time, null: false
  end
  end
